#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
http request

Authors: zhangyongyue(zhangyongyue@baidu.com)
Date:    2021/12/09
"""

import time
import json
import sys
import os
import requests
from spo_service.common.logger import Logger

class HttpPost(object):
    """
    @summary: http请求工具类
    """

    def __init__(self, uri, prefix, timeout):
        """
        @param host: a ip address or a domain name.
        @param port: MUST BE a decimal or can be convert to a demical.
        @note: host MUST not have the prefix: http://, and MUST not have ":"!!
        """
        self.api = "http://" + uri + prefix
        self.timeout = timeout
        self.params = '{}'
        logfile_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + \
            "/logs/kg_request_controller.log"
        self.logger = Logger(logfile=logfile_path, logname="httpclient")

    def set_data(self, _data, encode=False):
        """
        @summary: specify data to send in http message.
        @param _data: MUST BE a dict, the data to send in the body of http message.
        """
        if encode == False:
            self.params = json.dumps(_data)
        else:
            self.params = _data

    def do_post(self, json=False):
        """
        @summary: send a http post request.
        @return: a dict, if {} means error, judgement is needed. 
        """
        #try:
        if json == False:
            results = requests.post(self.api, data=self.params, timeout=self.timeout)
        else:
            results = requests.post(self.api, json=self.params, timeout=self.timeout)
        results.encoding = 'utf-8'
        return results.json()
        #except Exception as error:
        #    self.logger.error("http request is error: %s" % error)
        #    return {}

if '__main__' == __name__:
    httppost = HttpPost("10.9.224.54:8184", "/", 1)
    request = {}
    httppost.set_data(request)
    ret = httppost.do_post()
    print(ret)
