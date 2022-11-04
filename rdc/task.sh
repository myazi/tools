HADOOP_INPUT=/user/nlp-aurora/dingyuchen/baike/seg_para
HADOOP_OUTPUT=/user/nlp-aurora/dingyuchen/baike/seg_vec
HADOOP_INPUT_TEST=/user/nlp-aurora/yingwenjie/1_sub
HADOOP_OUTPUT_TEST=/user/nlp-aurora/dingyuchen/baike/seg_vec_test
TASK_NAME=dyc_baike_seg
# tar zxvf irqa_preprocess_v2.tar.gz >log 2>log; cd irqa_preprocess_v2; ./python_gcc4/bin/python IrqaPipeline.py ./conf/irqa_pipeline_baike.conf
#     -file irqa_preprocess_v2.tar.gz \
HDFS_TOOL=/user/nlp-aurora/yingwenjie/
/data/work/env/hadoop-client/hadoop/bin/hadoop fs -rmr $HADOOP_OUTPUT_TEST
/data/work/env/hadoop-client/hadoop/bin/hadoop streaming \
    -input $HADOOP_INPUT_TEST \
    -output $HADOOP_OUTPUT_TEST \
    -mapper "./python2.7/python27-gcc482-paddle1.8.1/bin/python map_request.py" \
    -reducer  "./python2.7/python27-gcc482-paddle1.8.1/bin/python reduce_request.py" \
    -file task_map.py \
    -file task_reduce.py \
    -jobconf mapred.job.name=$TASK_NAME \
    -jobconf mapred.job.map.capacity=1000 \
    -jobconf mapred.map.tasks=1000 \
    -jobconf mapred.reduce.tasks=1 \
    -jobconf stream.memory.limit=10000 \
    -jobconf mapred.map.over.capacity.allowed=false \
    -jobconf mapred.job.priority=VERY_HIGH \
    -jobconf abaci.job.base.environment=default \
    -cacheArchive ${HDFS_TOOL}/python27-gcc482-paddle1.8.1.tar#python2.7 
if [ $? -ne 0 ]
    then
    echo "hadoop error"
    exit 1
fi
#    -reducer "tar zxvf wordseg_dict.tar.gz >tmp_log; python wordseg.py" \
#    -reducer  "./python2.7/python27-gcc482-paddle1.8.1/bin/python reduce_request.py" \
    #-outputformat org.apache.hadoop.mapred.SequenceFileOutputFormat \
