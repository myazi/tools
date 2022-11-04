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

for line in sys.stdin:
    query, qc = line.strip("\n").split('\t')
    if query != pre_query:
        print(pre_query + "\t" + qc + "\t" + str(pv_query))
        pre_query = query
        pv_query = 1
    else:
        pv_query += 1

print(pre_query + "\t" + qc + "\t" + str(pv_query))
