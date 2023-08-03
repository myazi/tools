#########################################################################
# File Name: pos.py
# Author: yingwenjie
# mail: yingwenjie@baidu.com
# Created Time: 2023年02月24日 星期五 11时36分42秒
#########################################################################
import sys
import math

tp_list = []
with open("./data/dy_0310_tp") as f:
    for line in f:
        line_list = line.strip('\n').split('\t')
        pid, u, t, p = line_list[0:4]
        tp = [t, p]
        tp_list.append(tp)

query_set = set()
with open("./data/query_set") as f:
    for line in f:
        query = line.strip('\n')
        query_set.add(query)

class sample():
    
    def get_key(self, line, key):
        line_list = line.strip('\n').split('，')
        res = ""
        for l in line_list:
            if(l.startswith(key)):
                res = l.replace(key+": ", "")
        return res
    
    def sample_pipei_para(self, file_name1):
        with open(file_name) as f:
            for line in f:
                query = line.strip('\n')
                for tp in tp_list:
                    if query in tp[0] or query in tp[1].split("，简介: ")[0]:
                        print(query + "\t" + "\t".join(tp))
                        break
    
    def sample_pipei(self, file_name): ##key query
        with open(file_name) as f:
            for line in f:
                line_list = line.strip("\n").split("\t")
                if(len(line_list) < 6): continue
                query, title, para, url, score1, score2 = line_list[0:6]
                keys = [title]
                if float(score2) < 0.2: continue
                #keys.append(self.get_key(para, "电影名"))
                #keys.append(self.get_key(para, "电影别名"))
                #keys.append(self.get_key(para, "电影扩展名"))
                #keys.append(self.get_key(para, "导演"))
                #keys.append(self.get_key(para, "演员"))
                #keys.append(self.get_key(para, "上映地区"))
                #keys.append(self.get_key(para, "分类"))
                #keys.append(self.get_key(para, "标签"))
                keys.append(para.split("，简介: ")[0])
                #print(para)
                for k in keys:
                    #print(query + "\t" + k)
                    if (query in k) and query != "" and k != "":
                        print(line.strip())
                        break

            
    def sample_notpipei_index123(self, file_name):
        index = 1
        with open(file_name) as f:
            for line in f:
                line_list = line.strip("\n").split("\t")
                if(len(line_list) < 6): continue
                query, title, para, url, score1, score2 = line_list[0:6]
                if(query in query_set and query not in para and (index % 20 > 0 and index % 20 < 6) and float(score2) < 0.98):
                    print(line.strip())
                index += 1

    def sample_score_rank(self, file_name): ##泛化query
        index = 1
        with open(file_name) as f:
            for line in f:
                line_list = line.strip("\n").split("\t")
                if(len(line_list) < 6): continue
                query, title, para, url, score1, score2 = line_list[0:6]
                if float(score1) > 80 and float(score2) > 0.1 and (index % 20 > 0 and index % 20 <= 20) and title not in query and len(query) < 12:
                #if float(score1) > 90 and (index % 20 == 1):
                    print(line.strip())
                index += 1
        
    def sample_query_neg(self, file_ann, file_query):
        query_set = set()
        with open(file_query) as f:
            for line in f:
                query_set.add(line.strip('\n'))
        with open(file_ann) as f:
            index = 1
            for line in f:
                line_list = line.strip("\n").split("\t")
                if(len(line_list) < 6): continue
                query, title, para, url, score1, score2 = line_list[0:6]
                if query not in query_set: continue
                if(query not in para and (float(score1) < 100 and float(score2) < 0.1 and index % 10 > 3 and index % 10 < 8)):
                    print(line.strip())
                index += 1 

    def sample_pos_neg(self, file_name1, file_name2):
        sample = {}
        qt_set = set()
        with open(file_name1) as f:
            for line in f:
                line_list = line.strip("\n").split("\t")
                if(len(line_list) < 6): continue
                query, title, para, url, score1, score2 = line_list[0:6]
                qt = query + "_" + title
                if qt in qt_set: continue
                sample.setdefault(query, {})
                sample[query].setdefault("1", [])
                sample[query]["1"].append([query, title, para, "1", score2])
                qt_set.add(qt)

        with open(file_name2) as f:
            for line in f:
                line_list = line.strip("\n").split("\t")
                if(len(line_list) < 6): continue
                query, title, para, url, score1, score2 = line_list[0:6]
                qt = query + "_" + title
                if qt in qt_set: continue
                sample.setdefault(query, {})
                sample[query].setdefault("0", [])
                sample[query]["0"].append([query, title, para, "0", score2])
                qt_set.add(qt)

        for key in sample:
            if len(sample[key]) < 2: continue
            for l in sample[key]["1"]:
                print("\t".join(l))
            for l in sample[key]["0"]:
                print("\t".join(l))

    def get_label(self, para):
        para_list = para.split("，")
        s1 = 5000 # 默认用户数,中间档位偏下
        s2 = 50 # 默认评分，中间档位
        for l in para_list:
            if "用户数: " in l:
                try:
                    s1 = int(l.split(": ")[1])
                except:
                    s1 = 0
            if "豆瓣评分: " in l:
                #try:
                l = l.replace("Ratings","")
                s2 = int(l.split(": ")[1][0])
                #except:
                #    s2 = 0
        s1 = s1 if s1 > 0 else 5000 # 异常使用，默认用户数
        s2 = s2 if s2 > 0 else 50 #异常使用， 默认评分

        s1_list = [100, 1000, 5000, 10000, 50000, 100000, 200000, 500000, 1000000]
        index = 0
        for index in range(len(s1_list)):
            if(s1 <= s1_list[index]):
                break
        s1 = index + 1

        s1 = s1 if s1 <= 9 else 9
        s2 = s2 if s2 <= 9 else 9
        return s1, s2
    def sample_qtpl(self, file_name):
        with open(file_name) as f:
            for line in f:
                line_list = line.strip("\n").split("\t")
                if(len(line_list) < 4): continue
                query, title, para, label = line_list[0:4]
                s1, s2 = self.get_label(para)
                if label == "1":
                    label_score = int(label) * 100 + s1 * 10 + s2
                else:
                    label_score = 0
                print(query + "\t" + title + "\t" + para + "\t" + str(label_score) + "\t" + label)

    def sample_recall(self, file_name):
        query_dict = {}
        with open(file_name) as f:
            for line in f:
                line_list = line.strip("\n").split("\t")
                if(len(line_list) < 6): continue
                query, title, para, label_score, label, score = line_list[0:6]
                query_dict.setdefault(query, {})
                query_dict[query].setdefault("1", [])
                query_dict[query].setdefault("0", [])
                query_dict[query][label].append([title, para])
        
        for query in query_dict:
            if len(query_dict[query]["1"]) > 1 and len(query_dict[query]["0"]) > 1:
                print(query + "\t" + "\t".join(query_dict[query]["1"][0]) + "\t" + "\t".join(query_dict[query]["0"][0]) + "\t" + "0")
                print(query + "\t" + "\t".join(query_dict[query]["1"][1]) + "\t" + "\t".join(query_dict[query]["0"][1]) + "\t" + "0")
            elif len(query_dict[query]["0"]) > 1:
                print(query + "\t" + "\t".join(query_dict[query]["1"][0]) + "\t" + "\t".join(query_dict[query]["0"][0]) + "\t" + "0")
                print(query + "\t" + "\t".join(query_dict[query]["1"][0]) + "\t" + "\t".join(query_dict[query]["0"][1]) + "\t" + "0")
                


                

if __name__ == '__main__':
    file_name = sys.argv[1]
    #file_name1 = sys.argv[1]
    #file_name2 = sys.argv[2]
    #file_ann = sys.argv[1]
    #file_query = sys.argv[2]
    sample = sample()
    #sample.sample_pipei(file_name)
    #sample.sample_notpipei_index123(file_name)
    #sample.sample_pos_neg(file_name1, file_name2)
    #sample.sample_score_rank(file_name)
    #sample.sample_query_neg(file_ann, file_query)
    sample.sample_qtpl(file_name)
    #sample.sample_recall(file_name)
    
