#!/bin/bash
run_day=$1
#JOB_NAME=feed_production_hour_miniapp_icf_train_liushaojie06_${run_day}
JOB_NAME=feed_production_hour_miniapp_icf_train_${run_day}
HADOOP=/home/work/.hmpclient/bin/hadoop
HADOOP_CONF=/home/work/.hmpclient/hadoop-client/hadoop/conf/hadoop-site-vertical.xml

SHOW_PATH=afs://szth.afs.baidu.com:9902/user/feed_rdc/archive/shoubai-rdc-new/video-hotmodel-pipe/${run_day}/all_host_data

OUTPUT_PATH=afs://tianqi.afs.baidu.com:9902/user/feed/vertical/job_data/production/vertical_common/wangmengfei01/miniapp/itemcf/train/2099${run_day:4:4}/00

HDFS_TOOL=/user/feed/vertical/tools

echo "JOB_NAME:    ${JOB_NAME}"
echo "OUTPUT:   ${OUTPUT_PATH}"

${HADOOP} fs -conf ${HADOOP_CONF} -rmr ${OUTPUT_PATH}
${HADOOP} streaming \
    -conf ${HADOOP_CONF} \
    -D mapred.job.name="${JOB_NAME}" \
    -D mapred.job.map.capacity=1000 \
    -D mapred.job.reduce.capacity=500 \
    -D mapred.max.map.failures.percent=10 \
    -D mapred.map.tasks=1000 \
    -D mapred.reduce.tasks=500 \
    -D mapred.job.priority=VERY_HIGH \
    -D mapred.map.output.compress=true \
    -D mapred.map.output.compression.codec=org.apache.hadoop.io.compress.GzipCodec \
    -D mapred.output.compress=true \
    -D mapred.output.compression.codec=org.apache.hadoop.io.compress.GzipCodec \
    -D mapred.reduce.slowstart.completed.maps=0.9 \
    -D mapred.job.queue.name=feed-buffer \
    -D mapred.job.tracker=yq01-tianqi-job.dmop.baidu.com:54311 \
    -mapper  "./python2.7/python2.7.5/bin/python map.py" \
    -reducer "./python2.7/python2.7.5/bin/python reduce.py" \
    -file ./pv_map.py \
    -file ./pv_reduce.py \
    -file ./yongshang \
    -file ./all \
    -input ${SHOW_PATH} \
    -output ${OUTPUT_PATH} \
    -cacheArchive ${HDFS_TOOL}/python2.7.5.tar.gz#python2.7 

if [ $? -ne 0 ]; then
    echo "run hadoop fail!"
    exit 1
fi

${HADOOP} fs -conf ${HADOOP_CONF} -getmerge ${OUTPUT_PATH}  ./dianji_${run_day}.gz  

