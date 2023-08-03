# -*- coding: utf-8 -*-

import sys
import urllib
import requests
import numpy as np
import random
import json
import time
import struct
import base64

def b64str_2_vec(str, fmt='768f'):
    """
    change base64 string to vector
    """
    return struct.unpack(fmt, base64.b64decode(str))

def load_vector_query(inp_file):
    """
    入参: query向量文件， 格式 vec "\t" query内容, vec空格分割
    """
    vec_list = []
    query_list = []
    for line in open(inp_file):
        line_list = line.strip('\n').split("\t")
        if len(line_list) < 2:
            continue
        query_emb, query = line_list
        data = query_emb.strip('\n').split(' ')
        vector = [float(item) for item in data]
        norm = np.linalg.norm(np.asarray(vector))
        vector_norm = np.array(vector)/np.array(norm)
        vec_list.append(vector_norm)
        #vec_list.append(vector)
        query_list.append(query)
    return vec_list, query_list

def request_index_file(inp_file, topk, url="http://127.0.0.1:8085"):
    url = "http://127.0.0.1:8084"
    for line in open(inp_file):
        line_list = line.strip('\n').split("\t")
        if len(line_list) < 2:
            continue
        data = line_list[0].strip('\n').split(' ')
        query = line_list[1]
        vector = [float(item) for item in data]
        #norm = np.linalg.norm(np.asarray(vector))
        #vector = np.array(vector)/np.array(norm)
        data_dict = {}
        data_dict['vectors'] = [[_ for _ in vector]] #单条query向量
        data_dict['query'] = query # query文本内容
        data_dict['k'] = int(topk) # 返回topk相关para
        data_dict['ef'] = int(5000) #
        #print(data_dict)
        json_str = json.dumps(data_dict)#, encoding='utf8')
        result = requests.post(url, json_str)
        #print(result)
        res_json = json.loads(result.text)
        query = res_json.get('query', "null")
        paras = res_json.get('p', [[]])[0]
        offsets = res_json.get('o', [[]])[0]
        sim = res_json.get('s', [[]])[0]
        if len(paras) != len(offsets):
            continue
        for i in range(len(paras)):
            print(query + "\t" + paras[i] + "\t" + str(sim[i]) + "\t" + str(offsets[i])) 

if __name__ == '__main__':
    query_file = sys.argv[1] #query文件
    topk = sys.argv[2]
    url = sys.argv[3]
    request_index_file(query_file, topk, url)
