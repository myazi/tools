# -*- coding: utf-8 -*-

import sys
import urllib
import requests
import json
#import commands

inp_p_file = sys.argv[1]
url = "http://127.0.0.1:8086/recall_p" # para

data_dict = {}
data_dict['query'] = []
data_dict['title'] = []
data_dict['para'] = []
key_list = []

in_batch_cnt = 0
batch_size = 8
for line in open(inp_p_file, 'r'):
    v = line.strip().split('\t')
    if len(v) < 4:
        continue
    pid = v[0].replace(' ','')
    u = v[1].replace(' ','')
    title = v[2].replace(' ', '')
    para = v[3].replace(' ', '')
    query = '-'
    key = pid + "\t" + u + "\t" + title + "\t" + para

    in_batch_cnt += 1
    data_dict['query'].append(query)
    data_dict['title'].append(title)
    data_dict['para'].append(para)
    key_list.append(key)

    if in_batch_cnt == batch_size:
        try:
            json_str = json.dumps(data_dict)
            #quote_json_str = urllib.quote(json_str)
            result = requests.post(url, json_str)
            res_json = json.loads(result.text)
            #print(res_json)
            data_len = len(res_json['p_rep'])
        except:
            data_dict['query'] = []
            data_dict['title'] = []
            data_dict['para'] = []
            key_list = []
            in_batch_cnt = 0
            continue
        if data_len != batch_size:
            data_dict['query'] = []
            data_dict['title'] = []
            data_dict['para'] = []
            key_list = []
            in_batch_cnt = 0
            continue
        for i in range(data_len):
            key = key_list[i]
            print (key + "\t" + ' '.join(str(n) for n in res_json['p_rep'][i]))

        data_dict['query'] = []
        data_dict['title'] = []
        data_dict['para'] = []
        key_list = []
        in_batch_cnt = 0

json_str = json.dumps(data_dict)
#quote_json_str = urllib.quote(json_str)
result = requests.post(url, json_str)
res_json = json.loads(result.text)
data_len = len(res_json['p_rep'])
for i in range(data_len):
    print (key + "\t" + ' '.join(str(n) for n in res_json['p_rep'][i]))
