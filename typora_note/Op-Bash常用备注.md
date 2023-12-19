@[TOC](这里写自定义目录标题)

# Bash 常用备注

## 地址：

>   常规用法



```bash

- 获取脚本文件所在目录
script_path=$(cd `dirname $0`; pwd)

- 获取脚本文件的上级目录
script_path=$(cd `dirname $0`; pwd)
root_path=$(cd `dirname "$script_path"`; pwd) 

##find
find 命令只查找当前目录，不查找子目录
find . -maxdepth 1   -name "*.html" -exec rm -rf {}  \;
find . -maxdepth 1   -name "*.sh" -exec mv {} bash \;


只在当前目录下(不包含当前目录下的 子目录)查找以.html 为后缀的所有文件 然后删除
1.find . -type f  -maxdepth 1  -name "*html" | egrep -v "typora_note|test|notes|github-directory-downloader"  | xargs rm

2.删除当前目录 排除Other目录的其他文件和目录

find . | grep -v Other | xargs rm 

查找并且复制到另一个目录 同时展示有哪些文件 xargs -I 直接显示某个目录下的所有文件
find . -name "*.ts" |xargs -I {} cp {} /Users/xx/tools/script_dir/ts_dir


# 按日期范围查找文件
find . -type f -newermt "2010-01-01" ! -newermt "2010-06-01"

- 定时清理
    30 1 * * * /bin/find /data/filecache/ -type f -mtime +365 -exec rm -f {} \; >/dev/null 2>&1

    -mtime＋1 表示文件修改时间为大于1天的文件，即距离当前时间2天（48小时）之外的文件
    这里-mtime +1 为什么是48小时以外，而不是24小时以外呢，因为n只能是整数，比1大的下一个整数是2，所以是48小时以外的

- 查找docx文件

    find . -type f -name "*.docx"
    

##ps
背景：服务器CPU占用高，找出最高的分析，看是否进程正确，是否是垃圾进程

找出占用CPU 内存过高的进程前10位
echo "-------------------CUP占用前10排序--------------------------------"
ps -eo user,pid,pcpu,pmem,args --sort=-pcpu  |head -n 10
echo "-------------------内存占用前10排序--------------------------------"
ps -eo user,pid,pcpu,pmem,args --sort=-pmem  |head -n 10


对进程进行跟踪查看

查看进程打开的文件

lsof -p 进程PID

查看进程在处理的文件

ll /proc/进程PID/fd

查看进程的内存使用情况

pmap 进程PID

通过strace来跟踪进程的系统调用

strace -p 进程PID

当然我们也可以查看汇总的信息

strace -cp 进程PID

如果我们想跟踪某进程所有的系统调用，并统计调用时间，并导出为文件，可用如下命令

strace -o 导出文件 -T -tt -e trace=all -p 进程PID



ps -ef|grep scheduler_center.py|grep -v grep|awk '{print "kill -9 "$2}'|sh

##curl
curl 指定host ip 访问页面或接口
curl -H 'Host:www.test.com' http://10.44.54.111/test.php
或
curl -x 10.44.54.111:80 http://www.test.com/test.php


##awk
awk 文本转换成数组
awk -F: '{print $NF}'  sk.txt
cat sk.txt |awk -F" " '{for(i=1;i<=2;i++){print "\""$1"\"=>" "\""$2"\","}}'

行首或行尾插入：
sed 'p;s/^.*$/--------/' file
awk '{print $0;print "-------"}' file

确定文本打印处于start_pattern 和end_pattern之间的文本
awk '/GitHub520 Host Start/, /GitHub520 Host End/' /etc/hosts

时间范围： 按照时间范围搜索日志
awk '$2>"17:30:00" && $2<"18:00:00"' trace.log
日志形式如下, $2代表第二列即11:44:58, awk需要指定列

去掉文件中空行
awk NF  aaaa.txt

## sed
在每行记录的开头加上当前路径
ls | sed "s:^:`pwd`/:"    

## tar
分别单独压缩当前目录中的子目录，并以子目录的名字命名其压缩文件
for f in ./*;do if [ -d $f ]; then tar -zcvf $f.tgz $f; fi; done  


##crontab 
15 14 * * * nohup /usr/local/bin/python3.5 /data/xx/start.py > "/data/xx/logs/$(date +"\%Y\%m\%d").log" 2>&1



##cp 实践成功拷贝当前目录的隐藏文件如下：
cp -a  testFolder/. testFolder2/.

把文件夹 srcDir 复制到 destDir, srcDir 为 destDir 的子文件夹
cp -r srcDir destDir

把文件夹 srcDir 下的文件及子文件夹复制到 destDir
cp -r srcDir/ destDir 


## egrep文件中过滤参数(是或的关系)
egrep '2010009664|2010009118|2010009666' 35_output > 35_output_ret

过滤掉注释的行
egrep -v "^#|^$" /var/spool/cron/root

##其他
显示当前正在使用网络的进程
lsof -P -i -n | cut -f 1 -d " "| uniq | tail -n +2

快速创建项目目录
mkdir -p work/{project1,project2}/{src,bin,bak}

## file_put_contents 
file_put_contents('/data/ads.txt', 'data'.$data.PHP_EOL, FILE_APPEND);
file_put_contents('/data/ads.txt', "Arr:".var_export($contentArr, TRUE), FILE_APPEND);


## supervisorctl
supervisorctl stop program_name  # 停止某一个进程，program_name 为 [program:x] 里的 x
supervisorctl start program_name  # 启动某个进程
supervisorctl restart program_name  # 重启某个进程
supervisorctl stop groupworker:  # 结束所有属于名为 groupworker 这个分组的进程 (start，restart 同理)
supervisorctl stop groupworker:name1  # 结束 groupworker:name1 这个进程 (start，restart 同理)
supervisorctl stop all  # 停止全部进程，注：start、restartUnlinking stale socket /tmp/supervisor.sock
、stop 都不会载入最新的配置文件
supervisorctl reload  # 载入最新的配置文件，停止原有进程并按新的配置启动、管理所有进程
supervisorctl update  # 根据最新的配置文件，启动新配置或有改动的进程，配置没有改动的进程不会受影响而重启


查找正在联网的应用
lsof -P -i -n | cut -f 1 -d " "| uniq | tail -n +2

```



## 脚本

```bash

export_database.sh
#!/bin/bash


database='porsche'

for table in `mysql -h 192.168.1.170 -u dev '-pdev1234' porsche -Bse 'show tables'`
do
    if [ ! "$table" == 's_keyword' ]; then
        continue
    fi
    for i in {0..10000}
    do
        from=`echo "5000*$i"|bc`
        to=`echo "5000*($i+1)"|bc`
        export_file="$database.$table.$from.$to"
        mysqldump -h 192.168.1.170 -u dev '-pdev1234' --databases $database --tables $table --order-by-primary --where="id >= $from and id < $to" > ${export_file}
   count=`grep '^INSERT INTO ' ${export_file} | wc -l` 
        echo $i.$from.$to.${export_file}.$count
        if [ $count -le 0 ]; then
            rm "${export_file}"
            break
        fi
        echo "export to file $export_file"
    done
done


curl_es.sh
#!/bin/bash
#
# @desc: es分页导出json文件
# @author: zxc

page_size=1000
pageno=0
echo "---------------------curl es data start------------------------"
for temp in {1..30478};
do
   from=`expr $pageno \* $page_size`
   echo "size=$page_size,pageno=$pageno"
   echo "http://192.168.1.21:9200/my_index/_search?size=${page_size}&from=${from}"
   curl "http://192.168.1.21:9200/my_index/_search?size=${page_size}&from=${from}" >> /data/zxc/my_index_backup/backup.json
   echo -e >> /data/zxc/my_index_backup/backup.json
   pageno=`expr $pageno + 1`
done
echo "---------------------curl es data done------------------------"

#nohup bash curl_es.sh > /data/zxc/my_index_backup/es_bash.log 2>&1 &




del_elasticseatch_index.sh
#!/bin/bash
#The index 30 days ago
curl -XGET 'http://10.0.8.44:9200/_cat/shards' |awk '{print $1}' |grep `date -d "30 days ago" +%Y.%m.%d` |uniq > /tmp/index_name.tmp
 
for index_name in `cat /tmp/index_name.tmp` 
do
    curl -XDELETE  http://10.0.8.44:9200/$index_name
    echo "${index_name} delete success" >> /home/scripts/del_elasticseatch_index.log
done
 
[root@elk-node01 ~]# crontab -l
0 3 * * * bash del_elasticseatch_index.sh


merge_ts.sh

mkdir -p ~/Desktop/ts文件合并/原文件
mkdir -p ~/Desktop/ts文件合并/合并文件
find 文件夹路径 -name *.ts |xargs -I {} cp {} ~/Desktop/ts文件合并/原文件
cd ~/Desktop/ts文件合并/原文件
for file in `ls | sort -n`; do cat $file >> ~/Desktop/ts文件合并/合并文件/合并后的文件名.ts;done


rename_file.sh

#批量删除下列文件名中的"Operations" 并且替换成"Op"
for name in Operations*; do mv "${name}" "Op${name#Operations}"; done


```



#删除下列文件名中的"source-wuxi" 并且替换成"source-xibei"

![Linux 批量修改文件名_Linux 批量修改文件名](https://testingcf.jsdelivr.net/gh/91xcode/typora_img/img/typora/202312200000494)
