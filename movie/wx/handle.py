# -*- coding: utf-8 -*-# 
# filename: handle.py
import hashlib
import reply
import receive
import web
import json
import re
import time 
from spo_service.query_req_movie import search

class Handle(object):

    def process(self, fromUser, toUser, createTime, query):
        log_file = open("wx.log", 'a+')
        nid_res = search(query)
        process_res = []
        tp_set = set()
        for one in nid_res:
            url = one.get("sid", "null")
            score = one.get("s", "")
            title = one.get("t", "")
            paras = one.get("p", "")
            para_list = paras.split('，')
            actor = ""
            director = ""
            for para in para_list:
                if para.startswith("演员:"):
                    actor = re.sub('[a-zA-Z]', '', para)
                    actor = actor.replace("\xa0","")
                if para.startswith("导演:"):
                    director = re.sub('[a-zA-Z]', '', para)
            tp = title + "_" + director
            if (score > 0.6 and tp not in tp_set and len(process_res) < 5):
                #process_res.append([title, director, actor, url])
                process_res.append([title, str(score), actor, url])
                tp_set.add(tp)
        log_file.write(createTime + "\t" + fromUser + "\t" + toUser + "\t" + query + "\t" + str(process_res) + '\n')
        return process_res

    def GET(self):
        try:
            data = web.input()
            query = data.get("query", "")
            if query == "": return "query is null"
            fromUser = "web"
            toUser = "web"
            createTime = str(int(time.time()))
            process_res = self.process(fromUser, toUser, createTime, query)
            content = []
            for one in process_res:
                title = one[0]
                director = one[1]
                actor = one[2]
                url = one[3]
                title = "<a href=\"" + url  + "\">" + title + "</a>"
                content.append("<br>".join([title, director, actor]).replace("\xa0",""))
            if len(content) == 0:
                content = "null"
            else:
                content = "<br><br>".join(content)
            return content.encode("gbk")

            if len(data) == 0:
                return "hello, this is handle view"
            signature = data.signature
            timestamp = data.timestamp
            nonce = data.nonce
            echostr = data.echostr
            token = "guanfu" #请按照公众平台官网\基本配置中信息填写

            list = [token, timestamp, nonce]
            list.sort()
            sha1 = hashlib.sha1()
            map(sha1.update, list)
            hashcode = sha1.hexdigest()
            #print "handle/GET func: hashcode, signature: ", hashcode, signature
            if hashcode == signature:
                return echostr
            else:
                return echostr
        except Exception as Argument:
            return Argument

    def POST(self):
        try:
            webData = web.data()
            recMsg = receive.parse_xml(webData)
            if isinstance(recMsg, receive.Msg) and recMsg.MsgType == 'text':
                toUser = recMsg.FromUserName
                fromUser = recMsg.ToUserName
                createTime = recMsg.CreateTime
                msgType = recMsg.MsgType
                content = recMsg.Content.decode("utf8")
                process_res = self.process(fromUser, toUser, createTime, content)
                content = []
                for one in process_res:
                    title = one[0]
                    director = one[1]
                    actor = one[2]
                    url = one[3]
                    title = "<a href=\"" + url  + "\">" + title + "</a>"
                    content.append("\n".join([title, director, actor]))
                if len(content) == 0:
                    content = "null"
                else:
                    content = "\n\n".join(content)
                replyMsg = reply.TextMsg(toUser, fromUser, content)
                return replyMsg.send()
            else:
                print("暂且不处理")
                return "success"
        except Exception as Argment:
            print(Argment)
            return Argment
