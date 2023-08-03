# -*- coding: utf-8 -*-
import sys
import json
import codecs
query_dict = {}
query_dict["neg"] = []
query_dict["pos"] = []
pre_query = ""
with codecs.open("./data/query_sample_13W+1W_qtpl") as inp:
    for line in inp:
        line_list = line.strip('\n').split('\t')
        if len(line_list) < 4: continue
        #query, title, para, u, r, s, label = line_list
        query, title, para, label = line_list[0:4]
        sample = [title, para, label]
        if query != pre_query:
            max_score = 0
            if "pos" in query_dict:
                for sam in query_dict["pos"]:
                    score = int(sam[2])
                    #if score > 10000: continue
                    max_score = score if score > max_score else max_score
            if (len(query_dict["neg"])) > 0 and (len(query_dict["pos"])) > 0: #and (len(query_dict["neg"]) / len(query_dict["pos"]) * 1.0 < 1.5 ): #and max_score >= 2200:
                print(json.dumps(query_dict, ensure_ascii=False))
            query_dict = {}
            query_dict["query"] = query
            query_dict["neg"] = []
            query_dict["pos"] = []
        if label == "0":
            if len(query_dict["neg"]) < 5:
                query_dict["neg"].append(sample)
        else:
            if len(query_dict["pos"]) < 3:
                query_dict["pos"].append(sample)
        pre_query = query
if len(query_dict) > 1:
    if (len(query_dict["neg"])) > 0 and (len(query_dict["pos"])) > 0:
        print(json.dumps(query_dict, ensure_ascii=False))
#for k in num:
#    print("\t".join([str(i) for i in k]))
