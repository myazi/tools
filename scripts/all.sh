#########################################################################
# File Name: all.sh
# Author: yingwenjie
# mail: yingwenjie.com
# Created Time: Wed 27 May 2020 12:05:12 PM CST
#########################################################################
#!/bin/bash
source ~/.bashrc #文件包含进来
source ~/.bash_profile
BIN='./bin'
DATA_DIR='./data'
RESULT_DIR='./data/result'
GRAHP_TRY_DAY=10

#变量
#获取字符串长度
string="abcd"
echo ${#string[0]}   # 输出 4
#提取子字符串
string="runoob is a great site"
echo ${string:1:4} # 输出 unoo
#查找子字符串
string="runoob is a great site"
echo `expr index "$string" io`  # 输出 4

#数组
array_name=(value0 value1 value2 value3) #定义
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}
echo "数组的元素为: ${array_name[*]}"

#参数传递
echo "Shell 传递参数实例i"
echo "第一个参数为：$1"

echo "参数个数为：$#"
echo "传递的参数作为一个字符串显示：$*"
echo "传递的参数作为一个字符串显示：$@"

#运算
val=`expr 2 + 2`
echo "两数之和为 : $val"

# -eq, -nq, -ge, -le, -gt, -lt, -a[&&], -o[||], !
if [ $a != $b ]
then
    echo "$a != $b : a 不等于 b"
else
    echo "$a == $b: a 等于 b"
fi
if [ $a -lt 100 -a $b -gt 15 ]
then
    echo "$a 小于 100 且 $b 大于 15 : 返回 true"
else
    echo "$a 小于 100 且 $b 大于 15 : 返回 false"
fi
if [ $a -lt 100 -o $b -gt 100 ]
then
    echo "$a 小于 100 或 $b 大于 100 : 返回 true"
else
    echo "$a 小于 100 或 $b 大于 100 : 返回 false"
fi
if [ $a -lt 5 -o $b -gt 100 ]
then
    echo "$a 小于 5 或 $b 大于 100 : 返回 true"
else
    echo "$a 小于 5 或 $b 大于 100 : 返回 false"
fi
if [ -z $a ]
then
    echo "-z $a : 字符串长度为 0"
else
    echo "-z $a : 字符串长度不为 0"
fi
if [ -n "$a" ]
then
    echo "-n $a : 字符串长度不为 0"
else
    echo "-n $a : 字符串长度为 0"
fi
if [ $a ]
then
    echo "$a : 字符串不为空"
else
    echo "$a : 字符串为空"
fi

#函数
funWithParam(){
    echo "第一个参数为 $1 !"
    echo "第十个参数为 ${10} !"
    echo "参数总数有 $# 个!"
    echo "作为一个字符串输出所有参数 $* !"
}
if [ $? -eq 0 ]; then
    echo "上一条命令wget hadoop执行成功"
else
    echo "上一条命令wget hadoop执行失败"
do

#输出
printf "%-10s %-8d %c-1c %-4.2f\n" name 100 g 48.6543 ##字符串、整型、字符、小数
command > file 2>&1 ## 1标准输出、2标准错误输出，将1，2都重定向到file
command >> file 2>&1 ## 1标准输出、2标准错误输出，将1，2都重定向追加到file

# 文件/目录相关
if [ ! -d ./data ]; then
	mkdir ./data
fi
if [ ! -f ${DATA_DIR}/${day} ]; then
    echo "miss rdc_file ${day}"
    exit -1
fi
if [ -s ${RESULT_DIR}/res_${day} ]; then
    echo "${day} remain again"
    continue
fi

#循环操作
for file in `ls /etc`; do
done

## time相关
day=`date -d "-${j} days" +%Y%m%d`
one_day=`date -d "$day 00:00:00" +%s`
cur_day=`date -d "-${i} days" +%Y%m%d`
graph_date=${tm:0:8}

# 单进程运行
IP_FILE='run_daily.pid'
if [ -f ./$IP_FILE ];then
    date +%Y-%m-%d:%H-%M-%S
    echo "gicf not over" | mutt yingwenjie@baidu.com -s "last not finish"
    exit
fi
echo "${day} PID of this script: $$" > ./$IP_FILE"

for((i=1;i>0;i--));
do
    j=`expr $i + 1`

    wget -P ${DATA_DIR} ftp://local_ec:local_ec@xxx//home/disk1/yangjintai/workspace/jobs/local_video_report/result/${cur_day}/active_${cur_day}

    hadoop fs -D hadoop.job.ugi=xxx -D fs.default.name=xx -getmerge  afs://yinglong.afs.baidu.com:9902/user/feed_rcmc/job_data/production/rcmc_data/${cur_day}/00/local_ec_nid_set_video z_${cur_day}_00.gz

    /opt/compiler/gcc-8.2/lib/ld-linux-x86-64.so.2 --library-path /opt/compiler/gcc-8.2/lib `which python` ${BIN}/get_gender_cate_tags.py ${DATA_DIR}/nid_file_${cur_day} > ${DATA_DIR}/nid_dict_${cur_day}
done

#删除无用文件
DATE_LOG=`date -d " $DATE 1 hays ago" +%Y%m%d`
rm ${DATA_DIR}/$DATE_LOG
rm ${DATA_DIR}/click_*$DATE_LOG*

cluster_num=(8 10 12 16 24)
cluster_files=(xx_fangdichan_query xx_huahzuang_query xx_jiaju_query xx_jiankangyangsheng_query xx_jiaoyu_query xx_lvyou_query xx_meishi_query xx_qiche_query xx_shuma_query)
for cluster_file in ${cluster_files[@]}
do
    for cluster in ${cluster_num[@]}
    do
        output_cluster=./data/res_${cluster_file}_${cluster}
        /home/yanghaihua/anaconda2/envs/pytorch/bin/python3 ./bin/kmeans.py ./data/$cluster_file $cluster > ${output_cluster}
        cat ${output_cluster} | python ./bin/evaluation.py > ./data/res_${cluster_file}_${cluster}_evaluation
        output_png=./data/png_${cluster_file}_${cluster}
        rm -rf ${output_png}
        mkdir ${output_png} 
        cat ${output_cluster} | /home/yanghaihua/anaconda2/envs/pytorch/bin/python3 ./bin/wc.py ${output_png}  
    done
done

# mysql数据库操作
mysql -u root -p123456 -D yongshangyiti -e "select mthid, author from all_nid_details" > ${DATA_DIR}/history_mthid_details;
mysql --local-infile -uroot -p123456 yongshangyiti -e "LOAD DATA LOCAL INFILE  '${RESULT_DIR}/ertiao_nid_${day}'  REPLACE INTO TABLE microv_nid_info  FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' (event_day,nid,author,title,duration,public_time,click,short,finish_prob,finish_rate,zhuanhua,zhuanhua_show,dur_join_scc,like_v,follow,share,comment_view,dislike,active_join_scc,mthid,convert_type)"

# 遍历视频队列，获取最终结果
for key in local_ec_video kankan_video
do
{
    if [[ ${key} = "local_ec_video" ]]; then
    
    fi
    if [[ ${key} = "local_ec_video" ]]; then
    
    fi
} &

md5sum ./data/${dict} > ./data/${dict}.md5 

#!/bin/sh

LOG() {
    echo -e `date + '\n%Y-%m-%d %H:%M:%S'`, "$@"
}

#得到内容模型
GET_FILE(){
    sdir=$1
    ddir=$2
    filename=$3
    filename_md5=$4
    for(( i = 0; i <= 3; i++ ))
    do
        rm -f ${ddir}/$filename
        rm -f ${ddir}/$filename_md5

        #wget $sdir/$filename -O $ddir/$filemame
        wget ${sdir}/$filename 
        mv $filename ${ddir}/$filemame
        wget ${sdir}/$filename_md5
        mv $filename_md5 ${ddir}/$filename_md5
        new_md5=${ddir}/${filename}_cur_md5_bak
        cur_md5=${ddir}/${filename}_cur_md5
        rm -f new_md5
        
        md5sum ${ddir}/$filename | awk -F ' ' '{print $1}' > $new_md5
        cat ${ddir}/$filename_md5 | awk -F ' ' '{print $1}' > $cur_md5
        cat $cur_md5
        cat $new_md5
        diff $cur_md5 $new_md5 > /dev/null
        if [ $? -ne 0 ];then
            echo $?
            LOG 'content model md5 error'
            rm $new_md5
            rm ${ddir}/$filename
            rm ${ddir}/$filename_md5
            rm $cur_md5
            if [ i == 10 ]; then
               echo "md5 error"
               exit
            fi
        else
            rm $new_md5
            rm $cur_md5
            break
        fi
    done
}

VALID(){
   num=$1
   ori_num=$2
   file=$3
   echo ${num}
   echo ${ori_num}
   if [ ! -f $file ] || [ ${num} -lt $ori_num ]; then
       echo "gen pic ${file} failed"
       echo "gen pic ${file} failed" | mail -s "pic $file" ${email}
       rm $IP_FILE
       exit 1
   fi
}

VALID_NOT_EXIT(){
   ori_num=$1
   file=$2
   ret=$3
   num=`wc -l $file | awk '{print $1}'`
   echo ${num}
   echo ${ori_num}
   echo $file
   if [ ! -f $file ] || [ ${num} -lt $ori_num ]; then
       echo "gen pic ${file} failed"
       echo "gen ${file} failed" | mail -s " $file" ${email}
       ret=1
       return
   fi
   ret=0
}


GEN_FINAL(){
    tmp_file=$1
    formal=$2
    
    md5sum $tmp_file | awk '{print $1}' > $tmp_file.md5
    mv $tmp_file $formal
    mv $tmp_file.md5 $formal.md5
    chmod 775 $formal $formal.md5
}

GET_TEN(){
    add_time=$1
    minite_decimal=${add_time:10:1}
    minite=${add_time:10:2}
    pre=${add_time:0:10}
    if [ $minite_decimal -eq 0 ]; then
        minite=${add_time:11:1}
        ((reminder=$minite%10))
        ((minite=$minite-$reminder))
    fi
    
    ((reminder=$minite%10))
    ((minite=$minite-$reminder))
    
    if [ $minite -eq 0 ]; then
        minite=${minite}0
    fi

    echo $pre$minite
}

GET_ADD_DATA() {
    cur_time=$1
    pre=$2
    time_file=$pre/$time_file
    add_data=$pre/$add_data

    rm $add_data
    touch $add_data
    
    if [ ! -f $time_file ]; then
        echo 'no time file, touch one'
        tmp_time=${cur_time:0:4}"-"${cur_time:4:2}"-"${cur_time:6:2}" "${cur_time:8:2}":"${cur_time:10}":00"
        tmp_time=`date -d "$tmp_time 10 min ago" +%Y%m%d%H%M`
        echo $tmp_time > $time_file
    fi

    flag_time=`cat $time_file`
    flag=0
    while (($flag < 1))
    do
        time_format=${flag_time:0:4}"-"${flag_time:4:2}"-"${flag_time:6:2}" "${flag_time:8:2}":"${flag_time:10}":00"
        flag_time=`date -d "$time_format 10 min" +%Y%m%d%H%M`
        flag_date=${flag_time:0:8}
        flag_hour=${flag_time:8:4}
        echo $flag_date $flag_hour
        if [ $flag_hour -eq 2350 ]; then 
            flag_date=`date -d "$time_format 1 day" +%Y%m%d`
            echo $flag_date
        fi
        if [ $flag_time -gt $1 ]; then
            flag=1
        else
            ${HADOOP_FS_FEED} -get ${log_path}/${flag_date}/*${flag_time} data/
            cat data/*_${flag_time} | grep '"scene_info": \[' >> $add_data
            rm data/*_${flag_time}
            echo $flag_time
            echo $flag_time > $time_file
        fi
    done
}

GEN_FILE() {
    local_dir=$1
    if [ ! -d $1 ]; then
        mkdir -p $1
    fi
}

VALID_MD5(){
    filename=$1
    filename_md5=$2
    new_md5=${filename}_cur_md5_bak
    cur_md5=${filename}_cur_md5
    
    md5sum $filename | awk -F ' ' '{print $1}' > $new_md5
    cat $filename_md5 | awk -F ' ' '{print $1}' > $cur_md5
    cat $cur_md5
    cat $new_md5
    diff $cur_md5 $new_md5 > /dev/null
    sleep 1
    if [ $? -ne 0 ];then
        echo $?
        LOG 'valid md5 error'
        rm $new_md5
        rm $filename
        rm $filename_md5
        rm $cur_md5
        sleep 10s
        return 1
    else
        rm $new_md5
        rm $cur_md5
        return 0
    fi
}

