# -*- coding: utf-8 -*-# 
# filename: handle.py
import hashlib
import reply
import receive
import web
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

    def POST(self):
        try:
            webData = web.data()
            #print("Handle Post webdata is: " +  webData)
            #后台打日志
            recMsg = receive.parse_xml(webData)
            if isinstance(recMsg, receive.Msg) and recMsg.MsgType == 'text':
                toUser = recMsg.FromUserName
                fromUser = recMsg.ToUserName
                content = recMsg.Content.decode("utf8")
                nid_res = search(content)
                content = nid_res[0:2]
                replyMsg = reply.TextMsg(toUser, fromUser, content)
                return replyMsg.send()
            else:
                print("暂且不处理")
                return "success"
        except Exception as Argment:
            return Argment
