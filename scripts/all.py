#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import sys
import time
import math
import os
import copy

reload(sys)
sys.setdefaultencoding('utf-8')

def write_email_day(data, title, event_day):
    """
    发送邮件
    """
    first_line = "<h3>【用商一体视频Feed冷启数据】" + str(event_day) + " 报表</h3>"
    first_column = ["维度","新入资源数", "有展资源占比", "展现达300次占比","展现达到300次平均时长","前300次展现ctr","冷启队列占比","用商队列占比","大盘队列占比"] 
    sep = '</td><td>'
    content = []
    content.append("<tr><td>" + sep.join(first_column) + "</td></tr>")
    content.append("<tr><td>" + sep.join(data["Feed"]) + "</td></tr>")
    content_str = '''%s
        <div><table style=\"border-collapse:collapse;\" border=\"2\" display=\"block\">%s</table></div>''' % (first_line, sep.join(content))
    
    first_line = "<h3>【用商一体视频冷启队列冷启数据】" + str(event_day) + " 报表</h3>"
    first_column = ["维度","新入资源数", "有展资源占比", "展现达300次占比","展现达到300次平均时长","前300次展现ctr"] 
    sep = '</td><td>'
    content = []
    content.append("<tr><td>" + sep.join(first_column) + "</td></tr>")
    content.append("<tr><td>" + sep.join(data["lengqi"]) + "</td></tr>")
    content_str_lengqi = '''%s
        <div><table style=\"border-collapse:collapse;\" border=\"2\" display=\"block\">%s</table></div>''' % (first_line, sep.join(content))
    
    first_line = "<h3>【用商一体二跳冷启数据】" + str(event_day) + " 报表</h3>"
    first_column = ["维度","新入资源数", "有分发资源占比", "分发达100次占比","分发达到100次平均时长","用商队列占比","大盘队列占比","前100次分发快滑率","前100次分发完播率","前100次分发完成率","点赞","关注","分享","评论","点踩"] 
    sep = '</td><td>'
    content = []
    content.append("<tr><td>" + sep.join(first_column) + "</td></tr>")
    content.append("<tr><td>" + sep.join(data["ertiao"]) + "</td></tr>")
    content_str_ertiao = '''%s
        <div><table style=\"border-collapse:collapse;\" border=\"2\" display=\"block\">%s</table></div>''' % (first_line, sep.join(content))

    content_str += content_str_lengqi
    content_str += content_str_ertiao

    first_line = "<h3>冷启队列资源明细数据</h3>"
    first_column = ["nid","作者id", "title", "url",
        "public_time", "到达300的时间","冷启队列总展现量", "冷启队列总点击量\n"]
    
    sep = '</td><td>'
    content = []
    content.append("<tr><td>" + sep.join(first_column) + "</td></tr>")
    for nid in data["nids"]:
        content.append("<tr><td>" + sep.join(nid) + "</td></tr>")
    content_str1 = '''%s
        <div><table style=\"border-collapse:collapse;\" border=\"2\" display=\"block\">%s</table></div>''' % (first_line, sep.join(content))
    content_str += ('''<h1>  </h1>''' + content_str1)
    
    first_line = "<h3>二跳冷启队列资源明细数据</h3>"
    first_column = ["nid","作者id", "title", "url",
        "public_time", "到达100的时间","冷启队列总点击量\n"]
    
    sep = '</td><td>'
    content = []
    content.append("<tr><td>" + sep.join(first_column) + "</td></tr>")
    for nid in data["ertiao_nids"]:
        content.append("<tr><td>" + sep.join(nid) + "</td></tr>")
    sep = "\n"
    last_line = "<div> for information ----> yingwenjie@baidu.com</div>"
    content_str2 = '''%s
        <div><table style=\"border-collapse:collapse;\" border=\"2\" display=\"block\">%s</table></div>%s''' % (first_line, sep.join(content), last_line)
    content_str += ('''<h1>  </h1>''' + content_str2)


    email = "yingwenjie@baidu.com"
    print(email)
    print(content_str)
    cmd = "printf '%s' | mutt -s %s -e 'set content_type=\"text/html\"' -e 'my_hdr from:' %s " % (content_str,title,email)
    ret = os.popen(cmd)
    print(email)

import sys
import MySQLdb
def write_mysql(data_file, table_name):
    data_list = []
    tmp_list = []
    data_list2 = []
    i = 0
    with open(data_file) as f:
        for line in f:
            i += 1
            line_list = line.strip().split("\t")
            if len(line_list) < 2:
                print("write_sql err" + "\t" + str(len(line_list)) + "\t" + str(line_list))
                continue
            data_list.append(tuple(line_list))
            tmp_list.append(tuple(line_list))
            if i % 10 == 0:
                data_list2.append(tmp_list)
                tmp_list = []
    if i % 10 != 0:
        data_list2.append(tmp_list)

    # 打开数据库连接
    db = MySQLdb.connect("localhost", "root", "123456", "yongshangyiti", charset='utf8')

    # 使用cursor()方法获取操作游标 
    cursor = db.cursor()
    if table_name == "duan_video":
        sql = "INSERT INTO " + str(table_name) + "(event_day,author,vid,show_cnt,click_cnt,ctr,play_ratio,solution_show,h5_show,h5_click,zhuanhua,zhuanhua_ratio,gz,dz,sc,pl,zf,avg_q,avg_qratio,video_duration,play_all_time,click_user,two_open,play_times,mthid,public_time,input_frame,quickbuy_btn,buy_fail,buy_suc,solution_click) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    if table_name == "mthid_details":
        sql = "INSERT INTO " + str(table_name) + "(mthid,author) values(%s,%s) ON DUPLICATE KEY UPDATE author = values(author)"
        
    try:
        # 执行sql语句
        #cursor.execute(sql)
        #print(data_list)
        for batch_list in data_list2: #二跳分块插入，数据量大插入超时
            cursor.executemany(sql,batch_list) #批量插入函数
            # 提交到数据库执行
            db.commit()
    except Exception as e:
        print("insert fail")
        print("Error",str(e),sql)
        db.rollback()
    # 关闭数据库连接
    db.close()

import urllib
import requests
import json
import commands
def get_ip_and_port_by_bns(bns):

    """ get ip and port by bns; return one randomly """
    try:
        ret_str = commands.getoutput("get_instance_by_service -ip %s" % bns)
        #import subprocess
        #ret_str = subprocess.getoutput("get_instance_by_service -ip %s" % bns)
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
bns = "xxx.all"
url = get_ip_and_port_by_bns(bns)
    if in_batch_cnt == batch_size:
        json_str = json.dumps(data_dict, encoding='utf8')
        quote_json_str = urllib.quote(json_str)

        result = requests.post(url, quote_json_str)
        res_json = json.loads(result.text)
        data_len = len(res_json.get('p_rep', []))
