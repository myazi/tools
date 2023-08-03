#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
get rank result

"""

import time
import json
import sys
import os
import random
from spo_service.common.logger import Logger
from spo_service.common.httpclient import HttpPost


class RequestRank(object):
    """
    @summary: 精排服务请求
    """
 
    def __init__(self):
        """
        @summary: 初始化日志打印
        """
        logfile_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + \
            "/logs/kg_request_controller.log"
        self.logger = Logger(logfile=logfile_path, logname="RequestRank")

    def get_rank(self, ip_addr, qq):
        """
        @summary: 请求精排服务
        @param: bns_addr 精排服务地址列表
        @param: qq qq对
        """
        for _ in range(5):
            try:
                # 随机取一个地址
                #bns_addr_list = bns_addr.split(',')
                #self.logger.info("rank bns_addr_list len is: %s " % len(bns_addr_list))
                #idx = random.randint(0, len(bns_addr_list) - 1)
                #print(idx)
                #uri = bns_addr_list[idx]
                #self.logger.info("rank request uri is: %s " % uri)
                #self.logger.info("rank request qq is: %s" % qq)
                # 发起请求
                httppost = HttpPost(ip_addr, "", 2)
                querys = []
                titles = []
                paras = []
                for qtp in qq:
                    querys.append(qtp[0])
                    titles.append(qtp[1])
                    paras.append(qtp[2])
                data = {
                    "query": querys,
                    "titles": titles,
                    "paras": paras
                }
                httppost.set_data(data)
                start_time = time.time()
                self.logger.info("rank request start %s" % time.strftime("%Y-%m-%d-%H_%M_%S", time.localtime()))
                ret = httppost.do_post()
                end_request_time = time.time()
                self.logger.info("rank request time %s s" % str(end_request_time - start_time))
                break
            except Exception as error:
                self.logger.error("rank request error: %s " % error)
                continue
        return ret

if __name__ == "__main__":
    rank_ip = sys.argv[1]
    qtp_file = sys.argv[2]
    request_rank = RequestRank()
    with open(qtp_file) as f:
        for line in f:
            query, title, para = line.strip('\n').split('\t')[0:3]
            if len(query) + len(title) + len(para) > 1000:
                print("\t".join([query, title, para, str(-1)]))
                continue
            ret = request_rank.get_rank(rank_ip, [[query, title, para]])
            prob = ret.get("probability")[0]
            print("\t".join([query, title, para, str(prob)]))
