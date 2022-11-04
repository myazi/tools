# -*- coding: utf-8 -*-

import sys
import urllib
import requests
import json
import commands
import random

#inp_p_file = sys.argv[1]
#url = 'http://10.12.35.42:5321' #para
#url = 'http://10.12.35.42:8061' #query
#url = 'http://10.188.46.142 35000' #para

def get_ip_and_port_by_bns(bns):

    """ get ip and port by bns; return one randomly """
    try:
        ret_str = commands.getoutput("get_instance_by_service -ip %s" % bns)
    except Exception, e:
        return None
    items = []
    try:
        for item in ret_str.split("\n"):
            addr, ip, port = item.split(" ")
            port = int(port) + 1
            url = "http://" + str(ip) + ":" + str(port)
            try:
                result = requests.post(url)
                items.append((ip, int(port)))
            except:
                continue
    except:
        return None
    ret = items[random.randint(0, len(items) - 1)]
    url = "http://" + str(ret[0]) + ":" + str(ret[1])
    return url

bns = "group.gpu-mixer-T4-bvcaurora.STPD.all"
server_add = get_ip_and_port_by_bns(bns)

data_dict = {}
data_dict['query'] = []
data_dict['title'] = []
data_dict['para'] = []
data_dict['url'] = []

cnt = 0
in_batch_cnt = 0
batch_size = 10
#for line in open(inp_p_file, 'r'):
for line in sys.stdin:
    v = line.strip().split('\t')
#    if len(v) < 4:
#        continue
    title = v[0].replace(' ', '')
    para = v[1].replace(' ', '')
    url = v[2]
    query = '-'

    if in_batch_cnt == batch_size:
        json_str = json.dumps(data_dict, encoding='utf8')
        quote_json_str = urllib.quote(json_str)

        result = requests.post(server_add, quote_json_str)
        res_json = json.loads(result.text)
        data_len = len(res_json.get('p_rep', []))
        #data_len = len(res_json['p_rep'])
        #data_len = len(res_json['q_rep'])
        for i in range(data_len):
            p_rep = res_json['p_rep'][i]
            ori_u = data_dict['url'][i]
            ori_t = data_dict['title'][i]
            ori_p = data_dict['para'][i]
            print (' '.join([str(n) for n in res_json['p_rep'][i]]) + "\t" + ori_u + "\t" + ori_t + "\t" + ori_p)
            #print (str(res_json['p_rep'][i]) + "\t" + content[i])
            #print ' '.join(str(n) for n in res_json['p_rep'][i])
            #print ' '.join(str(n) for n in res_json['q_rep'][i])
            #print str(res_json['p_rep'])

        data_dict['query'] = []
        data_dict['title'] = []
        data_dict['para'] = []
        data_dict['url'] = []
        in_batch_cnt = 0
        cnt += 1
    data_dict['query'].append(query)
    data_dict['title'].append(title)
    data_dict['para'].append(para)
    data_dict['url'].append(url)
    in_batch_cnt += 1
    #break

json_str = json.dumps(data_dict, encoding='utf8')
quote_json_str = urllib.quote(json_str)
result = requests.post(server_add, quote_json_str)
res_json = json.loads(result.text)
data_len = len(res_json['p_rep'])
#data_len = len(res_json['q_rep'])
for i in range(data_len):
    p_rep = res_json['p_rep'][i]
    ori_u = data_dict['url'][i]
    ori_t = data_dict['title'][i]
    ori_p = data_dict['para'][i]
    print (' '.join([str(n) for n in res_json['p_rep'][i]]) + "\t" + ori_u + "\t" + ori_t + "\t" + ori_p)
    #print (' '.join([str(n) for n in res_json['p_rep'][i]]) + "\t" + content[i])
    #print (str(res_json['p_rep'][i]) + "\t" + content[i])
    #print (content[i] + "\t" + ' '.join([str(n) for n in res_json['p_rep'][i]]))
    #print ' '.join(str(n) for n in res_json['p_rep'][i])
    #print ' '.join(str(n) for n in res_json['q_rep'][i])
