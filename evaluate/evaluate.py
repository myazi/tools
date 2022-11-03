#########################################################################
# File Name: evaluate.py
# Author: yingwenjie
# mail: yingwenjie@baidu.com
# Created Time: 2022年11月01日 星期二 19时50分38秒
#########################################################################

import sys
import math
from sklearn.metrics import precision_recall_curve

def DCG(label_list):
    dcgsum = 0
    for i in range(len(label_list)):
        dcg = (2**label_list[i] - 1)/math.log(i+2, 2)
        # dcg = (label_list[i])/math.log(i+2, 2)
        dcgsum += dcg
    return dcgsum

def NDCG(label_list, topK):
    dcg = DCG(label_list[0:topK])
    ideal_list = sorted(label_list, reverse=True)
    ideal_dcg = DCG(ideal_list[0:topK])
    ideal_dcg = ideal_dcg if ideal_dcg > 0 else 0.0001
    return dcg / ideal_dcg

def cal_ndcg(res_info, k):
    has_ans_q_ndcg = 0
    ndcg_k= 0
    for q, infos in res_info.items():
        infos = sorted(infos, key=lambda x:x[1], reverse=True)
        label, score = zip(*infos)
        if len(set(label)) <= 1: continue #必须存在不同label的pairwise 
        has_ans_q_ndcg += 1
        q_dcg = NDCG(label, k)
        ndcg_k += q_dcg
    ndcg_k = ndcg_k * 100.0 / has_ans_q_ndcg if has_ans_q_ndcg > 0 else 0.1 #len(q_infos)
    return ndcg_k

def cal_pnratio(res_info):
    p = 0
    n = 0
    for qid, infos in res_info.items():
        label, score = zip(*infos)
        for i in range(len(infos)):
            l1, s1 = infos[i][0:2]
            for j in range(i+1, len(infos)):
                l2, s2 = infos[j][0:2]
                if l1 > l2:
                    if s1 > s2:
                        p += 1
                    elif s1 < s2:
                        n += 1
                elif l1 < l2:
                    if s1 < s2:
                        p += 1
                    elif s1 > s2:
                        n += 1
    pn = p / n if n > 0 else 0.0
    return p, n, pn

def cal_recall_k(res_info, k):
    recall_q = 0
    recall_q_all = 0
    recall_qp = 0
    recall_qp_all = 0
    for q, infos in res_info.items():
        label_infos = sorted(infos, key=lambda x:x[0], reverse=True)
        score_infos = sorted(infos, key=lambda x:x[1], reverse=True)
        label_sort, score = zip(*label_infos)
        score_sort, score = zip(*score_infos)
        recall_q += 1 if sum(score_sort[:k]) > 0 else 0 ##一个q下打分排序前k个中有一个是正例即可
        recall_q_all += 1 if sum(label_sort[:k]) > 0 else 0 ##一个q下原始label排序前k个中有一个是正例即可

        recall_qp += sum([ v > 0 for v in score_sort[:k]]) ##一个q下打分排序前k个中有多少正例
        recall_qp_all += sum([v > 0 for v in label_sort[:k]]) ## 一个q下原始label排序前k个中有多少正例
    recall_q_k = recall_q / recall_q_all if recall_q_all > 0 else  0.001 
    recall_qp_k = recall_qp / recall_qp_all if recall_qp_all > 0 else 0.001
    print("\t".join([str(v) for v in [recall_q, recall_q_all, recall_q_k]]))
    print("\t".join([str(v) for v in [recall_qp, recall_qp_all, recall_qp_k]]))
    return recall_q_k, recall_qp_k 

def cal_precision_k(res_info, k):
    precision_qp = 0
    precision_qp_all = 0
    for q, infos in res_info.items():
        infos = sorted(infos, key=lambda x:x[1], reverse=True)
        label, score = zip(*infos)
        if sum(label) <=0: continue #不考虑没有正例的q
        precision_qp += sum([v > 0 for v in label[:k]]) ## 一个q下打分排序前k个中有多少正例
        precision_qp_all += k ##qp数
    precision_qp_k = precision_qp / precision_qp_all if precision_qp_all > 0 else 0.001
    print("\t".join([str(v) for v in [precision_qp, precision_qp_all, precision_qp_k]]))
    return recall_q_k, recall_qp_k 

def cal_mrr(): #平均倒数排名，label第一位结果在score排序中位置倒数之和平均
    pass

def cal_auc(res_info):
    """
    纵坐标：真实正例被召回的比例，正例召回率，越大越好，TP/TP+FN
    横坐标：真实负例被召回的比例，负例误召回率，越小越好，FP/FP+TN
    """
    scoredict = dict()
    numbin = 1000000
    maxval = 1.0 
    minval = 0.0 
    step = (maxval-minval)/numbin
    inv_step = 1.0 / step
    total_pos = 0 
    total_neg = 0
    total_all = 0
    avg_q = 0
    for q, infos in res_info.items():
        for info in infos:
            label, score = info[0:2]
            avg_q += float(score)
            total_all += 1
            v = 1 if int(label) <= 0 else 0 ##负例
            c = 1 if int(label) > 0 else 0 ##正例
            total_neg += v
            total_pos += c
            score_bin = int((float(score) - minval) * inv_step)
            scoredict.setdefault(score_bin, [0, 0])
            scoredict[score_bin][0] += v
            scoredict[score_bin][1] += c
    print("number of pos: " + str(total_pos))
    print("number of neg: " + str(total_neg))
    print("number of bin len: " + str(len(scoredict)))
    sorted_list = sorted(scoredict.items(), key=lambda x:x[0], reverse=True)

    sum_pos = 0 
    sum_neg = 0 
    pretp = 0.0 
    prefp = 0.0 
    prepr = 0.0 
    roc_auc = 0.0 
    roc_curve = dict()
    pr_auc = 0.0 
    pr_curve = dict()
    for (binidx, value) in sorted_list:
        sum_neg += (float(value[0])/total_neg)
        sum_pos += (float(value[1])/total_pos)
        tp = float(sum_pos)
        fp = float(sum_neg)
        pr = float(sum_pos)/(sum_pos+sum_neg)

        delta =(fp-prefp)*(pretp+tp)*0.5
        roc_auc += delta
        fpidx = int(fp * 100)
        roc_curve[fpidx] = (fp, tp)

        delta = (tp-pretp)*(prepr+pr)*0.5
        pr_auc += delta
        tpidx = int(tp*100)
        pr_curve[tpidx] = (tp, pr)

        pretp = tp
        prefp = fp
        prepr = pr

    print ("ROC AUC:\t" + str(roc_auc))
    print ("PR AUC:\t" + str(pr_auc))
    print ("avg_ctr:\t"+ str(total_pos/total_all))
    print ("avg_q:\t" + str(avg_q/total_all))
    print ("copc:\t" + str(total_pos/avg_q))

    #print "ROC Curve:"
    #for (k,v) in sorted(roc_curve.items()):
    #    print v[0],"\t", v[1]
    #print "PR Curve:"
    #for (k,v) in sorted(pr_curve.items()):
    #    print v[0],"\t", v[1]

def cal_pr(res_info, pre_thre):

    info_all = []
    for q, infos in res_info.items():
        for info in infos:
            info_all.append(info)
    labels, scores = zip(*info_all)
    labels = [1 if l > 0 else 0 for l in labels]
    precisions, recalls, thresholds = precision_recall_curve(labels, scores)
    max_f1 = 0
    max_i = -1
    for i, pre in enumerate(precisions):
        if pre > pre_thre:
            f1 = 2 * pre * recalls[i] / (pre + recalls[i])  
            if f1 > max_f1:
                max_f1 = f1
                max_i = i
    if max_i == -1:
        print("pre_ther is high")
    else:
        print("precision_" + str(pre_thre*100) + "\t" + str(round(thresholds[max_i], 6)) + "\t" + str(round(precisions[max_i] * 100, 2)) + "\t" + str(round(recalls[max_i] * 100, 2)) + "\t" + str(round(max_f1 * 100, 2)))

def get_label_score(file_name):
    res_info = {}
    with open(file_name) as f:
        for line in f:
            line_list = line.strip().split('\t')
            if len(line_list) < 4: continue
            qid, t, label, score = line_list[0:4]
            res_info.setdefault(qid, [])
            res_info[qid].append([int(label), float(score)])
    return res_info

if __name__ == "__main__":
    file_name = sys.argv[1]
    res_info = get_label_score(file_name)
    ndcg_k = cal_ndcg(res_info, 5)
    print(ndcg_k)
    p, n, pn = cal_pnratio(res_info)
    print("\t".join(str(i) for i in [p, n, pn]))
    recall_q_k, recall_qp_k = cal_recall_k(res_info, 2)
    precision_q_k, precision_qp_k = cal_precision_k(res_info, 2)
    cal_auc(res_info)
    cal_pr(res_info, 0.2)
