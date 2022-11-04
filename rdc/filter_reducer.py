#!/bin/env python
#coding=utf-8
"""
query_filter
"""

import os, sys
import json
import re
pre_query = ""
pv_query = 0
query_flag_set = set(["flagA", "flagB"])

## query规则过滤
dict_hy = []
with open('./dict_hanyu_notspo.txt') as inp:
    for line in inp:
        line = line.strip().decode('gb18030')
        dict_hy.append(line)
dict_p = [u"是谁", u"是什么", u"什么是"]
multi_p = re.compile(u'.*(\?|？).+(\?|？).*')
def rule_filter(q):
    """
    query filter_rule
    """
    is_hy = False
    q = q.decode('gb18030')
    for p in dict_p:
        if q.endswith(p) or q.startswith(p):
            tmp = q.strip(p)
            if len(tmp) in [2, 3]:
                is_hy = True
                break

    for hy in dict_hy:
        if hy in q:
            is_hy = True
            break
    if u"身高" in q and u"体重" in q:
        is_hy = True
    if multi_p.search(q):
        is_hy = True
    return is_hy

for line in sys.stdin:
    line_list = line.strip("\n").split('\t')
    if (len(line_list) < 3): continue
    query, qc, flag = line_list[0:3]
    if query != pre_query:
        if "flagB" not in query_flag_set and pv_query > 1 and rule_filter(pre_query) == False: ## rule, pv > 1
            print(pre_query + "\t" + qc + "\t" + str(pv_query))
        pre_query = query
        pv_query = 1
        query_flag_set.clear()
    else:
        pv_query += 1
    query_flag_set.add(flag)

if "flagB" not in query_flag_set and pv_query > 1 and rule_filter(pre_query) == False: ## rule, pv > 1
    print(pre_query + "\t" + qc + "\t" + str(pv_query))

