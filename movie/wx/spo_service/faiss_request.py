#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
get faiss index

Authors: zhangyongyue(zhangyongyue@baidu.com)
Date:    2021/12/09
"""

import time
import json
import sys
import os
import random 
from spo_service.common.logger import Logger
from spo_service.common.httpclient import HttpPost
from spo_service.recall_request import RequestRecall


class RequestFaiss(object):
    """
    @summary: 检索服务请求
    """
 
    def __init__(self):
        """
        @summary: 初始化日志打印
        """
        logfile_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + \
            "/logs/kg_request_controller.log"
        self.logger = Logger(logfile=logfile_path, logname="RequestFaiss")

    def get_faiss_index(self, ip_addr, vector, k, query, query_id, ef):
        """
        @summary: 请求faiss检索服务
        @param: bns_addr 检索服务地址列表
        @param: vector 向量
        @param: k topk
        @param: query 检索词
        @param: query_id 检索词id
        """
        # 发起请求
        ret = {}
        for _ in range(5):
            try:
                #ip_addr_list = ip_addr.split(',')
                #self.logger.info("search_addr_list len is: %s " % len(ip_addr_list))
                #idx = random.randint(0, len(ip_addr_list) - 1)
                #print(idx)
                #uri = ip_addr_list[idx] + ":8091"
                #self.logger.info("search request uri is: %s " % uri)
                httppost = HttpPost(ip_addr, "", 10)
                data = {
                    "vectors": vector,
                    "k": k,
                    "query": query,
                    "query_id": query_id,
                    "nprobe": ef
                }
                httppost.set_data(data)
                start_time = time.time()
                self.logger.info("faiss request start %s" % time.strftime("%Y-%m-%d-%H_%M_%S", time.localtime()))
                ret = httppost.do_post()
                end_request_time = time.time()
                self.logger.info("faiss request time %s s" % str(end_request_time - start_time))
                break
            except Exception as error:
                self.logger.error("faiss request error: %s " % error)
                continue
        return ret

if __name__ == "__main__":

    query_bns = sys.argv[1]
    ann_ip = sys.argv[2]
    inp_file = sys.argv[3]
    topk = int(sys.argv[4])
    request_recall = RequestRecall()
    request_faiss = RequestFaiss()
    with open(inp_file) as f:
        for line in f:
            query = line.strip('\n').split('\t')[0]
            vector = request_recall.get_recall(query_bns, [query])
            ret = request_faiss.get_faiss_index(ann_ip, [vector], topk, query, "1", 800)
            s = ret.get("s",["0"])
            p = ret.get("p",["0"])
            s = s[0]
            p = p[0]
            if len(s) != len(p): continue
            for i in range(len(s)):
                print(query + "\t" + p[i] + "\t" + str(s[i]))
