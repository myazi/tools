#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import time
from queue import Queue, Empty
import json
import sys
import os
import numpy as np
from threading import Thread
import configparser
from mysite.spo_service.common.logger import Logger
from mysite.spo_service.faiss_request import RequestFaiss
from mysite.spo_service.rank_request import RequestRank
from mysite.spo_service.recall_request import RequestRecall


class QueryRequest(object):
    """
    @summary: 多线程query召回与预测
    """
    
    def __init__(self, thread_pool_size=10):
        """
        @summary: 服务初始化
        """
        # 服务配置
        self.thread_pool_size = thread_pool_size
        Req_Logger.info("query request service thread_pool_size is " + str(self.thread_pool_size))
        # 召回服务地址
        self.request_recall = RequestRecall()
        # faiss请求配置
        self.request_faiss = RequestFaiss()
        # 精排服务地址
        self.request_rank = RequestRank()
        # 阅读理解服务地址
        #self.request_mrc = RequestMrc()
        # 初始化结果
        self.index_result = []
        # query/cid映射
        self.tp_sid_map = {}

        self.para_ip = "http://127.0.0.1:8086/recall_p" ##para向量预测服务 v5
        self.query_ip = "http://127.0.0.1:8087/recall_q" ##query向量预测服务 v5
        self.spo_ip = "http://127.0.0.1:8081/spo" ##精排服务 spo
        self.music_ip = "http://127.0.0.1:8082/music" ##精排服务 music 
        self.ann_ip = "http://127.0.0.1:8085" ##ANN检索服务地址
    
    def process_faiss_ret(self, query, faiss_ret):
        """
        @summary: 处理检索结果，拼装精排入参
        @param: query
        @param: passages 检索结果
        """
        qp = []
        if "s" in faiss_ret and "p" in faiss_ret:
            distances = faiss_ret["s"][0]
            passages = faiss_ret["p"][0]
            for ind in range(len(passages)):
                answer = passages[ind].split("\t")
                qp.append([query, answer[0], answer[1]])
                self.tp_sid_map[answer[0] + answer[1]] = answer[2]
        return qp

    def get_top_k(self, score, topk):
        """
        @summary: 返回精排topk
        @param: score 相似分矩阵
        @param: topk 最终返回topk的index
        """
        #np.set_printoptions(suppress=True)
        np_score = np.asarray(score)
        res_score_index = []
        res_score = []
        for i in range(topk):
            index = np.argmax(score)
            res_score_index.append(index)
            res_score.append(score[index])
            score[index] = 0
        return res_score_index, res_score
            
    def worker(self, work_queue, recall_bns_addr, rank_bns_addr, search_ip_addr, mrc_ip_addr):
        """
        @summary: 线程执行
        @param: work_queue 线程队列
        @param: recall_bns_addr 召回地址列表
        @param: rank_bns_addr 精排地址列表
        @param: search_ip_addr 检索地址列表
        """
        while not work_queue.empty():
            try:
                query = work_queue.get(block=False)
            except Empty:
                break
            else:
                try:
                    Req_Logger.info("request query is %s" % query)
                    # 请求召回
                    vec_ret = self.request_recall.get_recall(recall_bns_addr, [query])
                    vec = vec_ret#['q_rep'][0]
                    # 请求faiss
                    ret = self.request_faiss.get_faiss_index(search_ip_addr, [vec], 10, query, query, 2048)
                    qp = self.process_faiss_ret(query, ret)
                    # 请求精排
                    q_spo_res = {"@id": query}
                    if len(qp) > 0:
                        ret = self.request_rank.get_rank(rank_bns_addr, qp)
                        # 排序取top1
                        res_score_index, res_score = self.get_top_k(ret['probability'], 10)
                        tps = []
                        for i, ind in enumerate(res_score_index):
                            #if res_score[i] >= 0.9398:
                            if res_score[i] >= 0.8:
                                sid = self.tp_sid_map[qp[ind][1] + qp[ind][2]]
                                tp = {'sid':sid, 't':qp[ind][1], 'p':qp[ind][2], 's':res_score[i]}
                                tps.append(tp)
                                if 'sid' in tp:
                                    self.index_result.append(tp)
                                print(tp)
                        # 请求阅读理解
                        #if len(tps) > 0:
                        #    mrc_ret = self.request_mrc.get_mrc(mrc_ip_addr, query, tps)
                            #print(mrc_ret)
                        #    if 'o' in mrc_ret:
                        #        q_spo_res['sid'] = mrc_ret['sid']
                        #        q_spo_res['s'] = mrc_ret['s']
                        #        q_spo_res['p'] = mrc_ret['p']
                        #        q_spo_res['o'] = mrc_ret['o']
                        #print(q_spo_res)

                except Exception as err:
                    Req_Logger.error("error query is %s, error is %s" % (query, err))
                else:
                    if 'sid' in q_spo_res:
                        self.index_result.append(q_spo_res)
                finally:
                    work_queue.task_done()

    def main(self, querys, recall_bns_addr, rank_bns_addr, search_ip_addr, mrc_ip_addr):
        """
        @summary: 线程调度
        @param: recall_bns_addr 召回地址列表
        @param: rank_bns_addr 精排地址列表
        @param: search_ip_addr 检索地址列表
        """
        work_queue = Queue()

        for query in querys:
            work_queue.put(query)

        threads = [
            Thread(target=self.worker, args=(work_queue, recall_bns_addr, rank_bns_addr, search_ip_addr, mrc_ip_addr)) \
                for _ in range(self.thread_pool_size)
        ]

        for thread in threads:
            thread.start()

        work_queue.join()

        while threads:
            threads.pop().join()


class GetQueryRes(object):
    """
    @summary: query召回主入口
    """

    def __init__(self, thread_pool_size=10):
        """
        @summary: 初始化
        @param: thread_pool_size 线程数
        """
        self.thread_pool_size = thread_pool_size

    def get_query_res(self, recall_bns_addr, rank_bns_addr, search_ip_addr, mrc_ip_addr, file_id, fin):
        """
        @summary: query搜索入口
        @param: recall_bns_addr 召回地址列表
        @param: rank_bns_addr 精排地址列表
        @param: search_ip_addr 检索地址列表
        @param: fin 标准输入流
        """
        # query整理
        querys = []
        #for query in fin.readlines():
        for query in fin:
            query = query.strip()
            querys.append(query)
        
        # 服务请求
        start_time = time.time()
        Req_Logger.info("query request start %s" % time.strftime("%Y-%m-%d-%H_%M_%S", time.localtime()))
        q_req = QueryRequest(self.thread_pool_size)
        q_req.main(querys, recall_bns_addr, rank_bns_addr, search_ip_addr, mrc_ip_addr)
        #print(q_req.index_result)
        end_request_time = time.time()
        Req_Logger.info("query request time %.0f s" % (end_request_time - start_time))
       
        # 结果处理
        output_str = ''
        for q_rank in q_req.index_result:
            ret_line = json.dumps(q_rank, ensure_ascii=False) + "\n"
            output_str += ret_line
        #print(output_str)
        with open('./kg_search_result', 'a+', encoding='utf-8') as f:
            f.write(output_str)
        return q_req.index_result


if __name__ == "__main__":
    np.set_printoptions(suppress=True)
    # 日志配置
    global Req_Logger
    logfile_path = os.path.dirname(os.path.abspath(__file__)) + "/logs/kg_request_controller.log"
    Req_Logger = Logger(logfile=logfile_path, logname="RequestFaiss")
    thread_pool_size = int(sys.argv[1])
    recall_bns_addr = sys.argv[2]
    rank_bns_addr = sys.argv[3]
    search_ip_addr = sys.argv[4]
    mrc_ip_addr = sys.argv[5]
    file_id = sys.argv[6]
    q_req = GetQueryRes(thread_pool_size)
    q_req.get_query_res(recall_bns_addr, rank_bns_addr, search_ip_addr, mrc_ip_addr, file_id, sys.stdin)

def search(query):
    np.set_printoptions(suppress=True)
    # 日志配置
    global Req_Logger
    logfile_path = os.path.dirname(os.path.abspath(__file__)) + "/logs/kg_request_controller.log"
    Req_Logger = Logger(logfile=logfile_path, logname="RequestFaiss")
    thread_pool_size = 10
    recall_bns_addr = "127.0.0.1:8087/recall_q"
    rank_bns_addr  = "127.0.0.1:8081/spo"
    search_ip_addr = "127.0.0.1:8085"
    mrc_ip_addr = 0
    file_id = "0"
    q_req = GetQueryRes(thread_pool_size)
    index_result = q_req.get_query_res(recall_bns_addr, rank_bns_addr, search_ip_addr, mrc_ip_addr, file_id, [query])
    return index_result
