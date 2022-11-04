# -*- coding: utf-8 -*-
"""
query_filter
"""
import sys
import io
import codecs
import json
import os
import re

#input_stream = io.TextIOWrapper(sys.stdin.buffer, encoding='gb18030')

filter_cate_list = ["医疗", "成人色情", "需求不明"]
filter_cate_set = set()
for cate in filter_cate_list:
    filter_cate_set.add(cate.decode("utf8").encode("gb18030"))
def filter_cate(cate):
    "cate filter"
    if cate in filter_cate_set:
        return True
    else:
        return False

pattern_A = ''
pattern_B = ''
if len(sys.argv) > 1:
    pattern_A = sys.argv[1].strip()
    pattern_B = sys.argv[2].strip()
            
is_file_A = False
is_file_B = False
file_path = os.environ['map_input_file'] ##map 输入数据文件
if re.search(pattern_A, file_path):
    print >> sys.stderr, 'processing file A:---' + file_path
    is_file_A = True
else:
    print >> sys.stderr, 'processing file B:---' + file_path
    is_file_B = True

if is_file_A:
    for line in sys.stdin:
        try:
            data = json.loads(line.strip(), encoding='gb18030')
        except:
            #print >>sys.stderr, line.strip()
            continue
        if 'se_li' not in data:
            #print >>sys.stderr, line.strip()
            continue
        info = data['se_li'][0]
        if 'query' not in info or 'qu_l1' not in info or 'ot_tr' not in info:
            #print >>sys.stderr, line.strip()
            continue
        query = info['query'].encode('gb18030')
        qc = info['qu_l1'].encode('gb18030')
        ot_tr = info["ot_tr"]
        try:
            ot_tr = json.loads(ot_tr, encoding='gb18030')
            dqa_qa = ot_tr.get('dqa_qa', 1000)
            dqa_qa = int(dqa_qa.split('|')[0])
        except:
            #print >>sys.stderr, line.strip()
            continue
        if dqa_qa < 120: 
            continue #问题过滤
        if filter_cate(qc): 
            continue #黄反医疗过滤
        print(query + "\t" + qc + "\t" + "flagA")

if is_file_B:
    for line in sys.stdin:
        query = line.strip('\n').split("\t")[0]
        print(query + "\t" + "-" + "\t" + "flagB")
