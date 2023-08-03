"""
get faiss index

Authors: zhangyongyue(zhangyongyue@baidu.com)
Date:    2021/09/27
"""

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import numpy as np
import json
import web
import faiss
import struct
import sys
import time

"""
RequestHandler类
处理 http请求
"""

class GetIndex:

    def POST(self):
        web.header('content-type', 'text/json')
        params = json.loads(web.data())
        vector = params['vectors']
        k = params['k']
        query = params['query']
        ef = params['ef'] 
        p_emb_matrix = np.asarray(vector)
        #FINDEX.ef = 4096
        faiss.ParameterSpace().set_index_parameter(FINDEX, "efSearch", int(4096))
        start_time = time.time()
        D,I = FINDEX.search(p_emb_matrix.astype('float32'), k)
        end_request_time = time.time()
        print("search time %s" % str(end_request_time - start_time))
        
        fo = open('../../data/nlp_game_info.txt.trans.vec', "r")
        fo.seek(0, 0)
        buffer_page = 1024 * 1024 * 1
        passages_list = []
        for offsetList in I:
            passages = []
            for offset in offsetList:
                offset = int(offset)
                
                try:
                    fo.seek(offset, 0)
                except:
                    continue 
                line = fo.readline()
                line = line.strip()
                fields = line.split("\t")
                passage = ''
                for ind in range(len(fields)-1):
                    passage += fields[ind]
                    if ind < len(fields)-2:
                        passage += "\t"
                passages.append(passage)
            passages_list.append(passages)

        response_object = {"error_code": "0", "error_message": "", "s": D.tolist(), \
            "o":I.tolist(), "p":passages_list,"query":query}
        message = json.dumps(response_object)
        fo.close()
        return message

class GetOffset:

    def POST(self):
        web.header('content-type', 'text/json')
        params = json.loads(web.data())
        offsets = params['offsets']
        fo = open('/root/work/tmp/afs_tmp_file', "r")
        
        passages_list = []
        for offset in offsets:
            fo.seek(offset)
            line = fo.readline()
            line = line.strip()
            fields = line.split("\t")
            dict = {}
            passage = ''
            for ind in range(len(fields)-1):
                passage += fields[ind]
                if ind < len(fields)-2:
                    passage += "\t"    
            passages_list.append(passage)
        
        response_object = {"error_code": "0", "error_message": "", "passages":passages_list}
        message = json.dumps(response_object)
        fo.close()
        return message


if __name__ == "__main__":
    index_arg = sys.argv[1]
    global FINDEX
    FINDEX = faiss.read_index('../../data/faiss_HNSW_SQ8.index')
    urls = (
         '/offset', 'GetOffset',
         '/', 'GetIndex'
    )
    app = web.application(urls, globals())
    app.run()

