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

#linux 命令
fdisk -l查看机器磁盘
mount /dev/hdc6 /mnt/hdc6

chmod -R 777 文件名 # 第一个7表示owner权限，group，others， 7 = r4 + w2 + x1,
chmod -R u|g|o|a-x 文件名 # u表示owner，g表示group，o表示others，a表示所有用户， -x表示去掉执行权限
chown -R 属主名  文件名 
chgrp -R 属组名 文件名 ## -R是递归，该目录下所有文件操作


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

Linux笔记：

1、常用命令50



					1、	cd命令 
						功能说明：切换目录。
						举    例：却换到根目录 ：cd /
					2、	ls命令 
					功能说明：列出目录内容。
					举    例：列出/var目录的文件和目录的信息 ：ls –l /var；最常用方式 ls –ltr 
	
					3、	cat命令 
					功能说明：查看小文件内容。
					举    例：查看test.txt 文件内容 ：cat test.txt
					cat -n textfile1 > textfile2 #带行号输入到textfile2
					cat -b textfile1 textfile2 >> textfile3  #带行号追加到textfile3
					cat /dev/null > /etc/test.txt #清空 /etc/test.txt 文档内容
	
					4、	chmod命令 
					功能说明：修改文件或目录权限。
					文件及目录的权限范围，包括：
					u：User，即文件或目录的拥有者；
					g：Group，即文件或目录的所属群组；
					o：Other，除了文件或目录拥有者或所属群组之外，其他用户皆属于这个范围；
					a：All，即全部的用户，包含拥有者、所属群组以及其他用户。
	
					权限的代号包括：
					r：读取权限，数字代号为4；
					w：写入权限，数字代号为2；
					x：执行或切换权限，数字代号为1；
					-：不具任何权限，数字代号为0；
	
					-R或--recursive：递归处理，将指定目录下的所有文件及子目录
					chmod 777 tt.file # 第一个7表示 user，第二是group，第三个是other
					chmod a+r #所有用户加可读权限
					chown 改变文件或目录的所属者
					举    例：修改test.sh 为自己可执行：chmod u+x test.sh 
	
					5、	chown命令 
					功能说明：变更文件或目录的拥有者或所属群组。
					举    例：修改test.txt 属主为mysql ：chown mysql:mysql test.txt
	
					6、	cp命令 
					功能说明：拷贝文件。
					举    例：拷贝文件test.sh 为 test.sh_bak：cp test.sh test.sh_bak
	
					7、	diff命令 
					功能说明：对比文件差异。
					举    例：对比文件test.sh test.sh_bak 是否有差异diff  test.sh test.sh_bak
	
					8、	find命令 
					功能说明：查询文件。
					举    例：查询本目录下面的test.txt：find ./ -name test.txt
					find . -name *.xx 
					find / -size +500M -print0|xargs -0 du -m |sort -nr
					find指令为找出500M以上的文件，print0和xargs -0配合使用，用来解决文件名中有空格或特殊字符问题。du -m是查看这些文件的大小，并以m为单位显示。最后sort -nr是按照数字反向排序（大的文件在前）
					
					9、	mv命令 
					功能说明：移动或更名现有的文件或目录。
					举    例：移动 test.sh到/bin目录下：mv test.sh /bin/
	
					10、rm命令 
					功能说明：删除文件或目录。
					举    例：删除文件test.sh ：rm test.sh
					
					11、touch命令 
					功能说明：创建一个空文件。
					举    例：创建一个空的test.txt文件：touch test.txt
	
					12、which命令 
					功能说明：在环境变量$PATH设置的目录里查找符合条件的文件。
					举    例：查询find命令在那个目录下面：which find
	
					13、ssh命令 
					功能说明：远程安全登录方式。
					举    例：登录到远程主机：ssh ${IP}
	
					14、grep命令 
					功能说明：查找文件里符合条件的字符串。
					举    例：从test.txt文件中查询test的内容：grep test test.txt
					15、wc命令 
					功能说明：统计行。
					举    例：统计test.txt文件有多少行：wc -l test.txt
	
					16、date命令 
					功能说明：查询主机当前时间。
					举    例：查询主机当前时间：date
	
					17、exit命令 
					功能说明：退出命令。
					举    例：退出主机登录：exit
	
					18、kill命令 
					功能说明：杀进程。
					举    例：杀掉test用户下面的所有进程：ps -ef | awk ‘$1==”test” {print $2}’ | xargs kill -9
	
					19、id命令 
					功能说明：查看用户。
					举    例：查看当前用户：id ；查询主机是否有test用户：id test
	
					20、ps命令 
					功能说明：查询进程情况。
					举    例：查询test.sh进程：ps -ef | grep test.sh
	
					21、sleep命令 
					功能说明：休眠时间。
					举    例：休眠60秒 ：sleep 60
					 
					22、uname命令 
					功能说明：查询主机信息。
					举    例：查询主机信息：uname -a
	
					23、passwd命令 
					功能说明：修改用户密码。
					举    例：使用root修改test用户的密码：passwd test
	
					24、ping命令 
					功能说明：查看网络是否通。
					举    例：查询本主机到远程IP的网络是否通：ping ${IP} 
	
					25、df命令 
					功能说明：查看磁盘空间使用情况。
					举    例：查看主机的空间使用情况 ：df -h
	
					26、echo命令 
					功能说明：标准输出命令。
					举    例：对变量test进行输出：echo $test
					
					27、pwd命令 
					功能说明：查询所在目录。
					举    例：查询当前所在目录：pwd
					
					28、head命令 
					功能说明：查看文件的前面N行。
					举    例：查看test.txt的前10行：head -10 test.txt
	
					29、tail命令 
					功能说明：查看文件的后面N行。
					举    例：查看test.txt的后10行：tail -10 test.txt
	
					30、mkdir命令 
					功能说明：创建目录。
					举    例：创建test目录：mkdir test
					
					31、du命令 
					功	能：该文件夹的完整路径 查看目录下大小
					举	例：du --max-depth 1 -lh
					
					32、wget命令
					功	能：远程获取命令
					举	例：wget ftp://yingwenjie:123456@bjhw-ps-superpage006232e5e1.bjhw.baidu.com///home/yingwenjie/workspace/user_business/local_rep/shangyang_dev/static_dict/mthid_dict
	wget xx@http:/home --user xx --password xx
	
					33、scp命令
					功	能：远程拷贝命令
					举	例：scp -r /home/space/music/ root@www.runoob.com:/home/root/others/
					scp root@www.runoob.com:/home/root/others/music /home/space/music/1.mp3
	
					34、ln命令
					功	能： 创建一个指向文件或目录的软链接
					举	例：ln -s file1 lnk1 
					
					35、whereis命令
					功	能：查找二进制文件
					举	例：whereis locate 查找 locate 程序相关文件，whereis -s locate查看 locate 的源码文件
					35、top命令
					功	能：查看cpu使用情况
					举	例： top -u yingwenjie
					
					36、free命令
					功	能：查看内存使用情况
					举	例：
					37、chgrp命令
					功	能：修改文件所属用户组
					举	例： chgrp user xxfile
					38、locate命令
					功	能：利用数据库进行文件查找
					举	例：
					39、mount命令
					功	能：文件系统挂载和卸载
					举	例： mount -a
					

**打包和压缩文件**  bunzip2 file1.bz2 解压一个叫做 'file1.bz2'的文件  bzip2 file1 压缩一个叫做 'file1' 的文件  gunzip file1.gz 解压一个叫做 'file1.gz'的文件  gzip file1 压缩一个叫做 'file1'的文件  gzip -9 file1 最大程度压缩  rar a file1.rar test_file 创建一个叫做 'file1.rar' 的包  rar a file1.rar file1 file2 dir1 同时压缩 'file1', 'file2' 以及目录 'dir1'  rar x file1.rar 解压rar包  unrar x file1.rar 解压rar包  tar -cvf archive.tar file1 创建一个非压缩的 tarball  tar -cvf archive.tar file1 file2 dir1 创建一个包含了 'file1', 'file2' 以及 'dir1'的档案文件  tar -tf archive.tar 显示一个包中的内容  tar -xvf archive.tar 释放一个包  tar -xvf archive.tar -C /tmp 将压缩包释放到 /tmp目录下  tar -cvfj archive.tar.bz2 dir1 创建一个bzip2格式的压缩包  tar -jxvf archive.tar.bz2 解压一个bzip2格式的压缩包  tar -cvfz archive.tar.gz dir1 创建一个gzip格式的压缩包  tar -zxvf archive.tar.gz 解压一个gzip格式的压缩包  zip file1.zip file1 创建一个zip格式的压缩包  zip -r file1.zip file1 file2 dir1 将几个文件和目录同时压缩成一个zip格式的压缩包  unzip file1.zip 解压一个zip格式压缩包  																			



sort命令：https://www.cnblogs.com/51linux/archive/2012/05/23/2515299.html
sort将文件的每一行作为一个单位，相互比较，比较原则是从首字符向后，依次按ASCII码值进行比较，最后将他们按升序输出。Sort默认支持 空格分隔符
sort -u seq.txt #排序去重，默认ascii码值，升序排序
sort -u -r seq.txt #排序去重，默认ascii码值，降序排序
sort -r number.txt -o number.txt #解决sort -r number.txt > number.txt重定向问题
sort -n number.txt #默认按ascii码值排序，-n按数值排序
sort -t : -n -k 2 facebook.txt  #-t 指定分隔符，-k 指定按那一列优先排序
sort -t ‘ ‘ -n -k 2 -k 3 facebook.txt  #-k 2 -k 3 先按第二列排序后，重复的按第三列排序
sort -t ‘ ‘ -n -k 3r -k 2 facebook.txt #-n 表示k3 k2都按数字排序，3r是k3按降序排序
sort -t ‘ ‘ -k 3nr -k 2n facebook.txt # 等同上面 
sort -t ‘ ‘ -k 1.2 facebook.txt # 1.2 #表示从第二个字符开始按第一列ascii值排序
sort -t ‘ ‘ -k 1.2,1.2 -k 3,3nr facebook.txt #表示按第一个阈的第二个字符ascii值排序，再按第三个阈按数值降序排序，3,3表示第三个阈后不再按其他阈排序
sort -n -k 2 -k 3 -u facebook.txt # -u 会对 -k2，k3结合去重
-f会将小写字母都转换为大写字母来进行比较，即忽略大小写
-c会检查文件是否已排好序，如果乱序，则输出第一个乱序的行的相关信息，最后返回1
-C会检查文件是否已排好序，如果乱序，不输出内容，仅返回1
-M会以月份来排序，比如JAN小于FEB等等
-b会忽略每一行前面的所有空白部分，从第一个可见字符开始比较。

sort file1 file2 排序两个文件的内容  sort file1 file2 | uniq 取出两个文件的并集(重复的行只保留一份)  sort file1 file2 | uniq -u 删除交集，留下其他的行  sort file1 file2 | uniq -d 取出两个文件的交集(只留下同时存在于两个文件中的文件)  

awk命令：https://www.cnblogs.com/ggjucheng/archive/2013/01/13/2858470.html

awk是一个强大的文本分析工具，相对于grep的查找，sed的编辑，awk在其对数据分析并生成报告时，显得尤为强大。简单来说awk就是把文件逐行的读入，以空格为默认分隔符将每行切片，切开的部分再进行各种分析处理。

grep

cut

sed



2、vim技巧



3、shell脚本

$? : 上一条命令是否执行成功，执行成功返回0，否则非0

4、linux管理+文件系统

