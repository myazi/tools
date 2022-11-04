# -*- coding: utf-8 -*-

import sys
import urllib
import requests
import json
import struct

out_fp = open("part_test" + '.bin', 'wb')
for line in sys.stdin:
    line_list = line.strip('\n').split('\t')
    if len(line_list) != 4:
        continue
    vectors, url, title, pas = line_list
    vectors = vectors.split(' ')
    vectors = [float(a) for a in vectors]
    value = url + "\t" + title + "\t" + pas
    vectors_bytes = struct.pack('{}f'.format(768), *vectors)
    #print(vectors_bytes)
    out_fp.write(vectors_bytes)
    value_encoded = value #.encode("UTF-8")
    value_len_int = len(value_encoded)
    value_len = struct.pack('I', value_len_int)
    #print(value_len)
    #print(value_encoded)
    out_fp.write(value_len)
    out_fp.write(value_encoded)
    #print(vectors_bytes)
    #print(value_len)
    #sys.stdout.write(vectors_bytes + value_len + value_encoded)
    #sys.stdout.write(value_len + "\t")

"""

def write_file(out_fp, vectors, value):
    vectors_bytes = struct.pack('{}f'.format(768), *vectors)
    #for item in range(768):
    #    vectors_bytes.extend(struct.pack('f', float(item)))
    out_fp.write(vectors_bytes)
    value_encoded = value #.encode("UTF-8")
    value_len_int = len(value_encoded)
    value_len = struct.pack('I', value_len_int)
    out_fp.write(value_len)
    out_fp.write(value_encoded)

inp_p_file = sys.argv[1]
#server_add = 'http://10.12.35.42:8764' #para
server_add = 'http://10.12.35.42:8060' #para
#server_add = 'http://10.12.35.42:48764' #para
out_fp = open(inp_p_file + '.bin', 'wb')

data_dict = {}
data_dict['query'] = []
data_dict['title'] = []
data_dict['para'] = []
data_dict['url'] = []

batch_size = 1
for line in open(inp_p_file, 'r'):
    v = line.strip().split('\t')
    title = v[0].replace(' ', '')
    para = v[1].replace(' ', '')
    url = v[2]
    query = '-'

    if len(data_dict['para']) == batch_size:
        json_str = json.dumps(data_dict, encoding='utf8')
        quote_json_str = urllib.quote(json_str)

        result = requests.post(server_add, quote_json_str)
        res_json = json.loads(result.text)
        #print res_json
        data_len = len(res_json['p_rep'])
        #data_len = len(res_json['q_rep'])
        for i in range(data_len):
            #print ' '.join(str(n) for n in res_json['p_rep'][i])
            p_rep = res_json['p_rep'][i]
            ori_u = data_dict['url'][i]
            ori_t = data_dict['title'][i]
            ori_p = data_dict['para'][i]
            write_file(out_fp, p_rep, ori_u + '\t' + ori_t + '\t' + ori_p)

        data_dict['query'] = []
        data_dict['title'] = []
        data_dict['para'] = []
        data_dict['url'] = []

    data_dict['query'].append(query)
    data_dict['title'].append(title)
    data_dict['para'].append(para)
    data_dict['url'].append(url)

json_str = json.dumps(data_dict, encoding='utf8')
quote_json_str = urllib.quote(json_str)
result = requests.post(server_add, quote_json_str)
res_json = json.loads(result.text)
data_len = len(res_json['p_rep'])
for i in range(data_len):
    #print ' '.join(str(n) for n in res_json['p_rep'][i])
    p_rep = res_json['p_rep'][i]
    ori_u = data_dict['url'][i]
    ori_t = data_dict['title'][i]
    pri_p = data_dict['para'][i]
    write_file(out_fp, p_rep, ori_u + '\t' + ori_t + '\t' + ori_p)
"""
