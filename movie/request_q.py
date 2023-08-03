# -*- coding: utf-8 -*-

import sys
import urllib
import requests
import json

inp_q_file = sys.argv[1]
url = 'http://127.0.0.1:8087/recall_q' #query

data_dict = {}
data_dict['query'] = []
data_dict['title'] = []
data_dict['para'] = []

cnt = 0
in_batch_cnt = 0
batch_size = 1
for line in open(inp_q_file, 'r'):
    v = line.strip().split('\t')
    query = v[0].replace(' ', '')
    title = '-'
    para = '-'

    data_dict['query'].append(query)
    data_dict['title'].append(title)
    data_dict['para'].append(para)
    in_batch_cnt += 1

    if in_batch_cnt == batch_size:
        json_str = json.dumps(data_dict)#, encoding='utf8')
        #quote_json_str = urllib.quote(json_str)

        result = requests.post(url, json_str)
        res_json = json.loads(result.text)
        #data_len = len(res_json['p_rep'])
        data_len = len(res_json['q_rep'])
        for i in range(data_len):
            query = data_dict["query"][i]
            print (' '.join(str(n) for n in res_json['q_rep'][i]) + "\t" + query)

        data_dict['query'] = []
        data_dict['title'] = []
        data_dict['para'] = []
        in_batch_cnt = 0
        cnt += 1

json_str = json.dumps(data_dict)#, encoding='utf8')
#quote_json_str = urllib.quote(json_str)
result = requests.post(url, json_str)
res_json = json.loads(result.text)
#data_len = len(res_json['p_rep'])
data_len = len(res_json['q_rep'])
for i in range(data_len):
    print (' '.join(str(n) for n in res_json['q_rep'][i]))
