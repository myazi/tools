#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#########################################################################
# File Name: process.py
# Author: yingwenjie
# mail: yingwenjie@baidu.com
# Created Time: 2023年02月21日 星期二 13时07分29秒
#########################################################################
import sys
import json

seg_list = ["movie_title", "translation", "movie_name", "director", "stars", "category", "tags", "douban_score", "release_date", "movie_place", "introduction", "awards", "language", "subtitle", "file_length", "movie_url"]
seg_map = {
        "movie_title": "电影名", \
        "translation": "电影别名", \
        "movie_name": "电影全名", \
        "director": "导演", \
        "stars": "演员", \
        "category": "分类", \
        "tags" : "标签", \
        "douban_score": "豆瓣分", \
        "release_date": "上映时间", \
        "movie_place": "上映地区", \
        "introduction": "简介", \
        "awards" : "获奖", \
        "language": "语言", \
        "subtitle": "字幕", \
        "file_length": "电影时长", \
        "movie_url": "下载地址"
        }
seg_set = {}
for key in seg_list:
    seg_set.setdefault(key, {})

def post(key, value_list):
    post_value = []
    top_v = 10 #每个字段只要前10个值
    for value in value_list:
        top_v -= 1
        if top_v < 0: continue
        if(key == "stars"): value.replace(".","") ##stars字段中剔除.
        if value == "": continue ##过滤掉为空的value
        values = value.strip().split("/")
        for v in values:
            post_value.append(v)
            seg_set[key].setdefault(v, 0)
            seg_set[key][v] += 1
    post_value = " ".join(post_value)
    return post_value

uniq_moive = set()       
for line in sys.stdin:
    try:
        line_json = json.loads(line)
    except:
        continue
    res = []
    for key in seg_list:
        if (key == "movie_url"): continue ##para中不拼url
        name = seg_map.get(key, "")
        value = line_json.get(key, [])
        post_value = post(key, value)
        if(key == "douban_score"):
            if(value== []): continue
            value_list = value[0].strip().split("from")
            if(len(value_list) < 2): continue
            score = value_list[0].split("/")[0]
            users = value_list[1].replace("users","").replace(",","")
            res.append("豆瓣评分" + ": " + str(score))
            res.append("用户数" + ": " + str(users))
        else:
            res.append(name + ": " + post_value)
    movie_name = line_json.get("movie_name","")
    movie_url = line_json.get("movie_url","")
    if movie_url not in uniq_moive:
        uniq_moive.add(movie_url)
        try:
            index1 = movie_name.index("《")
            index2 = movie_name.index("》")
            movie_name = movie_name[index1+1: index2]
        except:
            pass
        if movie_name != "":
            print(movie_name + "\t" + "，".join(res) + "\t" + movie_url)
        else:
            print(res.get("movie_title") + "\t" + "，".join(res) + "\t" + movie_url)

"""
v_set = set()
for key in seg_set:
    if len(seg_set[key]) != 0:
        for v in seg_set[key]:
            #print(seg_map.get(key,"") + ":  "  + v)
            if len(v.encode()) < 5 or len(v.encode()) > 50: continue
            if key == "movie_title" or key == "movie_title":
                v_set.add(v)
            else:
                if seg_set[key][v] > 2:
                    v_set.add(v)
for v in v_set:
    print(v)
print("===================")
with open("query_pv_all_utf8_ys_uniq", encoding="utf8") as f:
    for line in f:
        for v in v_set:
            if v in line:
                print(v + " : " + line.strip())
                break

"""
