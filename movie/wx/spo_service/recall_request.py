#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
get rank result

Authors: zhangyongyue(zhangyongyue@baidu.com)
Date:    2021/12/14
"""

import time
import json
import sys
import os
import random
import subprocess
from spo_service.common.logger import Logger
from spo_service.common.httpclient import HttpPost
import struct
import base64


class RequestRecall(object):
    """
    @summary: 召回预测服务请求
    """
    
    def __init__(self):
        """
        @summary: 初始化日志打印
        """
        logfile_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + \
            "/logs/kg_request_controller.log"
        self.logger = Logger(logfile=logfile_path, logname="RequestRecall")

    def _get_ip_and_port_by_bns(self, bns, bns_mapping=None):
        """ get ip and port by bns; return one randomly """
        bns_mapping = {} if bns_mapping is None else bns_mapping
        if bns not in bns_mapping:
            try:
                ret_str = subprocess.getoutput("get_instance_by_service -ip %s" % bns)
            except Exception as e:
                return None
            items = []
            try:
                for item in ret_str.split("\n"):
                    addr, ip, port = item.split(" ")
                    items.append(str(ip) + ":" + str(int(port)+1))
            except:
                return None
            ret = items[random.randint(0, len(items) - 1)]
        return ret

    def get_recall(self, bns_addr, query, title=[], para=[]):
        """
        @summary: 请求召回服务
        @param: bns_addr 召回服务地址列表
        @param: q query
        @param: title 标题，默认为空
        """
        for _ in range(5):
            try:
                # 随机取一个地址
                #uri = self._get_ip_and_port_by_bns(bns=bns_addr)
                uri = bns_addr
                self.logger.info("recall request uri is: %s " % uri)
                # 发起请求
                httppost = HttpPost(uri, "", 10)
                if len(title) == 0:
                    data = {
                        "query": query,
                        "title": [""],
                        "para": [""]
                    }
                else:
                    data = {
                        "query": query,
                        "title": title,
                        "para": para
                    }
                httppost.set_data(data)
                start_time = time.time()
                self.logger.info("recall request start %s" % time.strftime("%Y-%m-%d-%H_%M_%S", time.localtime()))
                ret = httppost.do_post()
                end_request_time = time.time()
                self.logger.info("recall request time %s s" % str(end_request_time - start_time))
                break
            except Exception as error:
                self.logger.error("recall request error: %s " % error)
                continue
        if len(title) == 0:
            return ret["q_rep"][0]
            #return ret["p_rep"][0]
        else:
            return ret["p_rep"][0]

def b64str_2_vec(str, fmt='768f'):
    """
    change base64 string to vector
    """
    return struct.unpack(fmt, base64.b64decode(str))

def vec_2_b64str(self, vec, fmt='768f'):
    """
    @summary: change vector to base64 string to save space
    @param: vec 向量
    @fmt: struct格式
    """
    b_vec = base64.b64encode(struct.pack(fmt, *vec))
    s_vec = str(b_vec, encoding='utf-8')
    return s_vec

if __name__ == "__main__":

    recall_bns = sys.argv[1]
    inp_file = sys.argv[2]
    request_recall = RequestRecall()
    with open(inp_file) as f:
        for line in f:
            line_list = line.strip('\n').split('\t')
            if len(line_list) < 4: continue
            sid, title, para, label = line_list
            ret = request_recall.get_recall(recall_bns, [""], title=[title], para=[para])
            print("\t".join([sid, title, para, ret]))
