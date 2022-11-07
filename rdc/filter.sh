#########################################################################
# File Name: author.sh
# Author: yingwenjie
# mail: yingwenjie.com
# Created Time: Wed 27 May 2021 12:05:12 PM CST
#########################################################################
#!/bin/bash
source ~/.bashrc
ROOT_DIR="."
DATA_DIR="./data"
BIN="./bin"
LOG_DIR="./log"
email="yingwenjie@baidu.com"
#dd=9
dd=$1
day=`date -d "-${dd} days" +%Y%m%d`
echo ${day}
A="gz"
B="xxx"

##当天任务是否已完成
if [ -s ./data/query_filter_${day} ]; then
    echo "done"
    exit 1
fi

# 进程是否正在执行
IP_FILE='run_daily.pid'
if [ -f ./$IP_FILE ];then
    echo "not over!"
    exit -1
fi
echo "${day} PID of this script: $$" > ./$IP_FILE

### 拉取大搜query数据，先判断数据是否都落盘了
HOUR=24
for((i=0;i<${HOUR};i++));
do
    hh=`echo ${i} | awk '{printf("%02d\n",$0)}'`
    INPUT_PATH="afs://xxx/user/sasd-dqadisp/wise_log/mergedata_v/${day}/${hh}/complete.success"
    hfs fs -D hadoop.job.ugi="sasd-dqadisp,298571" -test -e ${INPUT_PATH}
    if [ $? -ne 0 ]; then
        echo "no_finish"
        echo ${INPUT_PATH}
        rm -rf ./$IP_FILE
        exit -1
    fi
done
echo "starting"
hfs distcp -m 200 -su username,passwd -du username2,passwd afs1 afs2

HDFS_TOOL=/user/nlp-aurora/yingwenjie/
HADOOP_INPUT_TEST=/user/nlp-aurora/yingwenjie/query/query_log_${day}/*/part-*-A.gz
HADOOP_INPUT_HISTORY=${HDFS_TOOL}/query/query_pv_history_dir
HADOOP_INPUT_KG_SPO=${HDFS_TOOL}/query/query_kg_spo_${day}/*
HADOOP_OUTPUT_TEST=/user/nlp-aurora/yingwenjie/query/query_filter_${day}

/data/work/env/hadoop-client/hadoop/bin/hadoop fs -rmr $HADOOP_OUTPUT_TEST
/data/work/env/hadoop-client/hadoop/bin/hadoop streaming \
    -input ${HADOOP_INPUT_TEST},${HADOOP_INPUT_HISTORY}/* \
    -output $HADOOP_OUTPUT_TEST \
    -mapper  "./python2.7/python27-gcc482-paddle1.8.1/bin/python map_filter.py ${A} ${B}" \
    -reducer "./python2.7/python27-gcc482-paddle1.8.1/bin/python reducer_filter.py" \
    -file filter_map.py \
    -file filter_reducer.py \
    -file dict_hanyu_notspo.txt \
    -jobconf mapred.job.name=$TASK_NAME \
    -jobconf mapred.job.map.capacity=1000 \
    -jobconf mapred.map.tasks=1000 \
    -jobconf mapred.reduce.tasks=100 \
    -jobconf stream.memory.limit=100000 \
    -jobconf mapred.map.over.capacity.allowed=false \
    -jobconf mapred.job.priority=VERY_HIGH \
    -jobconf abaci.job.base.environment=default \
    -cacheArchive ${HDFS_TOOL}/python27-gcc482-paddle1.8.1.tar#python2.7

if [ $? -ne 0 ]
    then
    echo "hadoop error"
    rm -rf ./$IP_FILE
    exit 1
fi

## 产出天级更新query上传到历史query的afs上
hfs fs -getmerge ${HADOOP_OUTPUT_TEST} ./data/query_filter_${day} 
new_line=`wc -l ./data/query_filter_${day} | awk -F " " '{print $1}'`
if [ ${new_line} -le 0 ]; then
    echo "gen new_file failed"
    rm ./data/query_filter_${day}
    rm -rf ./$IP_FILE
    exit -1
fi
hfs fs -put ./data/query_filter_${day} ${HADOOP_INPUT_HISTORY}

### 跑KG分类模型
cat ./data/query_filter_${day} | python2 request.py > ./data/query_filter_${day}_filter_spo
query_line=`wc -l ./data/query_filter_${day}_filter_spo | awk -F " " '{print $1}'`
if [ ${query_line} -le 0 ]; then
    echo "KG_SPO_cate_model failed"
    rm -rf ./$IP_FILE
    exit -1
fi

### 最终有效query放到afs：user/nlp-aurora/kgdata/querys/${day}
dir=./data/query_filter_${day}_filter_spo_dir
if [ ! -d ${dir} ];then
      mkdir ${dir}
  else
      echo "dir is exist"
      rm -rf ${dir}
      mkdir ${dir}
fi
split -l 100000 ./data/query_filter_${day}_filter_spo -d -a 5 ${dir}/part_
file_all=`ls ${dir}` 
for i in $file_all
do
     echo $i >> ${dir}/part_complete
done 
hfs fs -put $dir afs://xxx:9902/user/nlp-aurora/kgdata/querys
hfs fs -mv afs://xxx:9902/user/nlp-aurora/kgdata/querys/query_filter_${day}_filter_spo_dir afs://xxx:9902/user/nlp-aurora/kgdata/querys/${day}

ddd=`expr $dd + 10`
history_day=`date -d "-${ddd} days" +%Y%m%d`
echo ${history_day}
hfs fs -rmr /user/nlp-aurora/yingwenjie/query/query_kg_*${history_day}
hfs fs -rmr /user/nlp-aurora/yingwenjie/query/query_log_*${history_day}
hfs fs -rmr /user/nlp-aurora/yingwenjie/query/query_filter_*${history_day}
#hfs fs -rmr /user/nlp-aurora/kgdata/querys/${history_day}
rm -rf ./$IP_FILE

exit 0
