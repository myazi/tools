# -*- coding: utf-8 -*-# 
# filename: handle.py
import hashlib
import reply
import receive
import web
import json
import re
from spo_service.query_req_movie import search

class Handle(object):
    def GET(self):
        try:
            data = web.input()
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

    def process(self, fromUser, createTime, query):
        nid_res = search(query)
        if len(nid_res) == 0:
            return "null" #无结果,返回null
        content = []
        tp_set = set()
        for one in nid_res:
            url = one.get("sid", "null")
            score = one.get("s", "")
            title = one.get("t", "")
            para = one.get("p", "")
            para_list = para.split('，')
            actor = ""
            director = ""
            for para in para_list:
                if para.startswith("演员:"):
                    actor = re.sub('[a-zA-Z]', '', para)
                    actor = actor.replace("\xa0","")
                if para.startswith("导演:"):
                    director = re.sub('[a-zA-Z]', '', para)
            tp = title + "_" + director
            if (score > 0.8 and tp not in tp_set and len(content) < 3):
                content.append("\n".join([title, director, actor, "资源地址: " + url]))
                tp_set.add(tp)
        print(createTime + "\t" + fromUser + "\t" + query + "\t" + str(content))
        if len(content) > 0:
            return "\n\n".join(content)
        else:
            return "null"

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
                content = self.process(fromUser, createTime, content)
                replyMsg = reply.TextMsg(toUser, fromUser, content)
                return replyMsg.send()
            else:
                print("暂且不处理")
                return "success"
        except Exception as Argment:
            print(Argment)
            return Argment
