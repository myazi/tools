#########################################################################
# File Name: vec.py
# Author: yingwenjie
# mail: yingwenjie@baidu.com
# Created Time: 2023年02月22日 星期三 21时19分36秒
#########################################################################
import sys
import numpy

para_vec = []
with open("all_dy_iutpv") as f:
    for line in f:
        pid, url, title, para, vec = line.strip('\n').split('\t')
        vec_list = vec.split(' ')
        vec_list = [float(_) for _ in vec_list]
        para_vec.append(vec_list)

para_vec = numpy.array(para_vec)

query_vec = []
with open("queryv") as f:
    for line in f:
        vec_list = line.strip('\n').split('\t')[0].split(' ')
        vec_list = [float(_) for _ in vec_list]
        query_vec.append(vec_list)

query_vec = numpy.array(query_vec)
print(para_vec.shape)
print(query_vec.shape)
sim = numpy.dot(para_vec, query_vec.T)
print(numpy.argmax(sim,axis=0))
print(numpy.max(sim,axis=0))

