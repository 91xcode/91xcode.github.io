@[TOC](这里写自定义目录标题)

# Mac 注意要点

## 需求

>   Mac 注意要点

## 步骤



0.Mac键盘图标与对应快捷按键

  ```
  　　⌘——Command （）
  　　⌃ ——Control
  　　⌥——Option （alt）
  　　⇧——Shift
  　　⇪——Caps Lock
  　　fn——功能键就是fn
  
      ⌘/：command
  
      ⇧：shift
  
      ⌥：option(alt)
  
      ^：control
  
      ↩/⌅：enter(return)
  
      ⇥：tab
  
      ⎋：esc（左上方的escape键）
  
      ⏏：eject（右上方的介质推出键）
  
      ⇪：caps lock
  
      mac 快捷键强制关闭程序 command+option+esc
  
      mac 打开 Finder，同时按下 command、shift、G  进入任何目录
  ```

1.MacOS Hight Sierra清除DNS缓存

```
sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;
```

2.mac  切换版本

```

brew switch formula version

brew switch python 3.7.4_1
```

3.常规查询&&shell

```


指定(排除)目录查找文件
find . -path "./document" -prune -o -name "*.txt" -print


查找指定文件 复制到指定目录中
find . -name "*.jpeg" -exec mv {} liu \;

find . -type f -mtime +10 -name "*.txt" -exec cp {} OLD \;

Linux 批量删除
find  *\(1\).jpg -exec rm -rf {} \;

只在当前目录下(不包含当前目录下的 子目录)查找以.html 为后缀的所有文件 然后删除
find . -type f  -maxdepth 1  -name "*html" | egrep -v "typora_note|test|notes|github-directory-downloader"  | xargs rm

删除当前目录 排除Other目录的其他文件和目录

find . | grep -v Other | xargs rm

查找
rg --files . | rg -e ".dmg$"

查找后缀名的文件 移动到指定文件夹中
find . -name "*.alfredworkflow" -exec  mv {} alfredworkflow \;


mac xargs与cp结合批量copy文件
ls *.dmg |xargs -I {} sudo  cp {} install

Mac批量删除进程
ps -ef | grep Pandas.py | grep -v 'grep' | awk '{print $2}' | xargs kill -9


过滤掉注释的行-符号注释：-v排除；^#：表示以#符号开头； ^$表示空行;直接查看 ^$：加起来表示空行，$表示行尾
egrep -v "^#|^$" ~/.zshrc

统计目录文件大小
du -sh * | sort -hr

tar打包整个目录(可排除子目录)几种方法
tar zcvf backup.tar.gz  --exclude=lua/aa --exclude=lua/bb  lua

去掉文件中空行
awk NF  aaaa.txt

确定文本打印处于start_pattern 和end_pattern之间的文本
awk '/GitHub520 Host Start/, /GitHub520 Host End/' /etc/hosts

shell 常规
#!/usr/bin/env bash
PREFIX=$(cd "$(dirname "$0")"; pwd)
cd $PREFIX


目录按大小排序
du -hd1 | sort -hr


软连接
ln -s  myfile mylink      建立myfile 文件的软链接 mylink
ln -s /path/to/file_or_directory path/to/symlink

删除软链接
正确的是：rm -rf hb_link
错误的是：rm -rf hb_link/ 这个会把整个目录都删了
```

4.vim设置和操作

```
cp /usr/share/vim/vimrc ~/.vimrc

然后在  set backspace=2下面一行插入如下代码

syntax on    "自动语法高亮
set nocompatible  "去掉有关vi一致性模式，避免以前版本的bug和局限
set nu!                                    "显示行号
set autoindent   "vim使用自动对齐，也就是把当前行的对齐格式应用到下一行(自动缩进）
set smartindent "依据上面的对齐格式，智能的选择对齐方式，对于类似C语言编写上有用
set showmatch "设置匹配模式，类似当输入一个左括号时会匹配相应的右括号
set hls  " 搜索时高亮显示被找到的文本
set incsearch  " 输入搜索内容时就显示搜索结果
set shiftwidth=4  " 设定 << 和 >> 命令移动时的宽度为 4
set ts=4  "设置tab键为4个空格，
set ruler "在编辑过程中，在右下角显示光标位置的状态行
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
set cursorline  " 突出显示当前行


vim操作

取消高亮
:nohl

拷贝整个文件 :%y
代码格式化：gg=G（即连续按2个g，再按=，再按G）

:set paste
进入paste模式以后，可以在插入模式下粘贴内容，不会有任何变形

文件最末端：G
文件最开始端：gg
显示行号： :set nu
隐藏行号:  :set nu!
$  移至当行行尾，
0（数字） 移至当行行首，
b移动到单词第一个字母 w移动到单词最后一个字母


vim如何搜索URL
?http://my.url.com/a/b/c 

```

5.下载

```

下载指定页面的全部资源
wget -r -p -np -k -P . https://www.baidufe.com/fehelper/naotu/index.html

多线程下载
axel -n 10 -o /tmp/ https://download3.vmware.com/software/fusion/file/VMware-Fusion-11.5.5-16269456.dmg

指定10个线程，存到/tmp/：如果下载过程中下载中断可以再执行下载命令即可恢复上次的下载进度

```

6.PHP写文件

```

file_put_contents('/data/ads.txt', 'data'.$data.PHP_EOL, FILE_APPEND);

file_put_contents('/data/ads.txt', "Arr:".var_export($contentArr, TRUE), FILE_APPEND);

```

7.字符串md5&&字符串长度

```

字符串md5
md5 -s Welcome

字符串长度
ss=123456
echo ${#ss}

```

8.Mac升级Node.js和npm到最新版本指令

```


一.查看本机当前Node.js和npm版本
node -v
npm -v

二.清除node.js的cache
sudo npm cache clean -f

三.安装"n"版本管理工具，管理node.js
sudo npm install -g n

四.更新node.js版本
sudo n stable

五.更新npm版本
sudo npm install npm@latest -g


npm怎么降级
npm install npm@6.9 -g

Node快速切换版本、版本回退(降级)、版本更新(升级)
安装node版本管理模块n
sudo npm install n -g

版本降级/升级
sudo n 版本号

检测目前安装了哪些版本的node
sudo n

切换版本（不会删除已经安装的其他版本）
n 版本号

删除版本
sudo n rm 版本号
比如删除本人电脑存在的6.9.1版可使用sudo n rm 6.9.1

```

9.supervisorctl

```

brew install supervisor
To have launchd start supervisor now and restart at login:
  brew services start supervisor
Or, if you don't want/need a background service you can just run:
  supervisord -c /usr/local/etc/supervisord.ini
  supervisorctl -c /usr/local/etc/supervisord.ini



关停一个程序的多个进程
supervisorctl  stop feishu_bot:*

To:/usr/local/etc/supervisor.d/lumen-worker.conf
[program:lumen-worker]
process_name=%(program_name)s_%(process_num)02d
command=php /usr/local/Cellar/openresty/nginx/html/test_lumen/lumen/artisan queue:work --tries=3 --daemon
autostart=true
autorestart=true
user=root
numprocs=8
redirect_stderr=true
stdout_logfile=/usr/local/Cellar/openresty/nginx/html/test_lumen/lumen/worker.log



 supervisorctl stop program_name  # 停止某一个进程，program_name 为 [program:x] 里的 x
 supervisorctl start program_name  # 启动某个进程
 supervisorctl restart program_name  # 重启某个进程
 supervisorctl stop groupworker:  # 结束所有属于名为 groupworker 这个分组的进程 (start，restart 同理)
 supervisorctl stop groupworker:name1  # 结束 groupworker:name1 这个进程 (start，restart 同理)
 supervisorctl stop all  # 停止全部进程，注：start、restartUnlinking stale socket /tmp/supervisor.sock
 、stop 都不会载入最新的配置文件
 supervisorctl reload  # 载入最新的配置文件，停止原有进程并按新的配置启动、管理所有进程
 supervisorctl update  # 根据最新的配置文件，启动新配置或有改动的进程，配置没有改动的进程不会受影响而重启
 
 
```

10.postman

```


Pre-request-script:

st = Math.round(new Date().getTime()/1000);
postman.setGlobalVariable("servicest", st);
sg = CryptoJS.MD5(st + 'db206a42f4b24933886c7472c0d8e336')
postman.setGlobalVariable("servicesg", sg);

Tests:

var jsonData = JSON.parse(responseBody);
tests["code"] = jsonData.code === "0”;



Pre-request-script:
timestamp = Math.round(new Date().getTime()/1000);

pm.environment.set("timestamp", timestamp);

g_timestamp = pm.environment.get("timestamp");
console.log(g_timestamp)
Tests:

var JsonData=JSON.parse(responseBody)
pm.environment.set("job_id", JsonData.data.job_id);
g_job_id = pm.environment.get("job_id");
console.log(g_job_id)


Postman 传递二维数组
review_info[0][id]:2
review_info[0][review_result]:30
review_info[0][shut_adset]:1
review_info[0][shut_ad]:1
review_info[0][note]:noo


```



11.redis

```
查看redis队列里面的一条数据
lrange 队列名称 0 0

获取redis队列中2个数据
lrange gallery_load_data 0 1

redismq格式
lpush mq_work:comment '{"method":"addComment","params":{"ids":"33"}}'

redis 获取含有前缀的key
KEYS "cmb:common:history:*"

测试数据是否进入redis
redis-cli -h 127.0.0.1 -p 6379  monitor | grep Mozilla

访问redis
telnet host 6379


执行 redis-cli 时 加上 --raw     // 中文输出设置
--raw 显示中文，而不是"\xd6\xd0"


redis有序集合查看全部元素
ZRANGEBYSCORE new_delay_queue:send_message -inf +inf   WITHSCORES 
ZRANGEBYSCORE new_delay_queue:send_message -inf +inf   WITHSCORES  

redis有序集合删除元素
ZREM new_delay_queue:send_message 70_30


 //Redis频次控制

$redis = new Redis();
$redis->pconnect("127.0.0.1", 6379);
$lua = <<<LUA
    local final = 0
    local times = redis.call('incr', KEYS[1])
    if times == 1 then
        redis.call('expire', KEYS[1], ARGV[1])
    end
    if times >= tonumber(ARGV[2]) then
        final = -1
    end
    return final
LUA;
$sha = $redis->script("load", $lua);
$keys = array("147.0.0.1", 60, 10);
$result = $redis->evalSha($sha, $keys, 1);
if ($result == -1) {
    echo "ip request too much";
}

//scan使用

/* With Redis::SCAN_RETRY enabled */
$redis->setOption(Redis::OPT_SCAN, Redis::SCAN_RETRY);
$it = NULL;

/* phpredis will retry the SCAN command if empty results are returned from the
   server, so no empty results check is required. */
while ($arr_keys = $redis->scan($it,"*member")) {
    foreach ($arr_keys as $str_key) {
        echo "Here is a key: $str_key\n";
    }
}
echo "No more keys to scan!\n";

```

12.mysql

```


mysql 数据库在一般情况下，对与字符类型的查询，是不区分大小写的。

清空表数据 truncate table table_name;

其中有提到时间范围的问题：

时间范围
date -- > '1000-01-01' to '9999-12-31'.
datetime --> '1000-01-01 00:00:00' to '9999-12-31 23:59:59'.
timestamp -- > '1970-01-01 00:00:01' UTC to '2038-01-19 03:14:07' UTC  //timestamp和时区相关

mysql时间数据类型有date，year，datetime，timestamp和time这5种子类型，除了timestamp数据类型外，其它均与时区无关。

CREATE DATABASE `atom` CHARACTER SET utf8mb4 COLLATE utf8mb4_bin

强制--唯一索引名为 uk_字段名;普通索引名则为 idx_字段名。
说明:uk_ 即 unique key;idx_ 即 index 的简称。

mysql按日期group by分组查询
SELECT DATE_FORMAT( deteline, "%Y-%m-%d %H" ) , COUNT( * ) FROM test GROUP BY DATE_FORMAT( deteline, "%Y-%m-%d %H" ) 

查询某天：deteline, "%Y-%m-%d

某时：deteline, "%Y-%m-%d %H"


mysql -uroot -p  --local-infile=1;
use load_data_test;
load data local infile '/tmp/test.txt'  into table test fields terminated by','  (`name`,`card_id`,`phone`,`bank_id`,`email`,`address`,`create_at`);


本地IP（xxx.xxx.xxx.xxx）没有访问远程数据库的权限。于是下面开启本地IP（xxx.xxx.xxx.xxx）对远程mysql数据库的访问权限
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
flush privileges;


explain优化

explain extended
select * from student 
where id in (
select student_id from student_score  where
course_id=1 and score=100
);
# 执行完上一句之后紧接着执行
mysql> show warnings;

SELECT
    `demo`.`student`.`id` AS `id`,
    `demo`.`student`.`name` AS `name` 
FROM
    `demo`.`student` semi
    JOIN ( `demo`.`student_score` ) 
WHERE
    (
        ( `<subquery2>`.`student_id` = `demo`.`student`.`id` ) 
        AND ( `demo`.`student_score`.`score` = 100 ) 
    AND ( `demo`.`student_score`.`course_id` = 1 ) 
    )
```



13.application/json 与 application/x-www-form-urlencoded的简单比较

```


curl -X POST 'http://localhost:8080/formPost' -d 'id=1&name=foo&mobile=13612345678'

curl -X POST -H "Content-Type: application/json" 'http://localhost:8080/jsonPost' -d '{"id":2,"name":"foo","mobile":"13656635451"}'

```



14.退出telnet命令

```

正确的命令 ctrl+]  然后在telnet 命令行输入 quit  就可以退出

```

15.目录里面的文件写到一个列表

```

python3 -c "import os;print(f\"var music_data={os.listdir('./songs/')}\")" > music_list.js

```

16.zsh的alias

```

alias lx='ls -lhBX'        #sort by extension
alias lz='ls -lhrS'        #sort by size
alias lt='ls -lhrt'        #sort by date    最常用到，ls -rt，按修改时间查看目录下文件
alias lsd='find . -maxdepth 1 -type d | sort'   #列出所有目录

alias size='f(){ du -sh $1* | sort -hr; }; f'
alias count='ls -1 | wc -l'
alias now='date "+%Y-%m-%d %H:%M:%S"'

```

17.git操作

```

git删除远程分支和本地分支
git push origin --delete xx_meiti

git branch -d Chapater8 可以删除Chapater8分支。


git submodule init
git submodule update

git checkout -b dev origin/dev 
本地创建一个dev分支，指向远程的dev分支


```

18.Execl 的vlookup

```
VLOOKUP 新建一列，在新建列的选择一个单元格 输入=VLOOKUP进行设置，然后鼠标放到该行右下脚➕处 Mac双击 该列的值都出来了 
=VLOOKUP(M2,'/Users/lien/Desktop/未命名文件夹/[提醒.xlsx]Sheet1'!$A:$B,2,FALSE)
```

19.MB/s 和 Mb/s 的理解

```
B 是 Byte
b 是 bit

1MB /s = 8Mb/s

楼主要求的是 40Mbps ，其实是每秒 5MB 的下载速度。电信运营商的宽带的带宽，一般说的 n M ，指的是 n Mb/s ，所以普通的百兆宽带就能满足楼主的要求。
```

20.服务器CPU占用高，找出最高的分析，看是否进程正确，是否是垃圾进程

 ```
 
 
 找出占用CPU 内存过高的进程前10位
 echo "-------------------CUP占用前10排序--------------------------------"
 ps -eo user,pid,pcpu,pmem,args --sort=-pcpu  |head -n 10
 echo "-------------------内存占用前10排序--------------------------------"
 ps -eo user,pid,pcpu,pmem,args --sort=-pmem  |head -n 10
 ```



### 21. git全局log配置

```
git config --global alias.ls "log --no-merges --color --graph --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Cblue %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit"

使用 git ls 或者 git ls -p

git config --global alias.lss "log --no-merges --color --stat --graph --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Cblue %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit"

使用 git lss 或者 git lss -p


查看单个文件的修改历史
git lss -p filename.php

查看指定成员 以及commit 含有的字符串
git lss --author liubing1 --grep '销售' -p
git lss --author liubing1
```

### 22. PHPSTORM去除警告波浪线的方法，IDEA应该也适用

```
  Preferences-Editor-Color Scheme-General-Errors and Warnings

  进入上述说的步骤之后，找到Weak Warnings取消Error stripe mark和Effects勾选，应用保存即可。
```

### 23.alfred 安装扩展 

  https://github.com/91xcode/Alfred-Workflow_List-Processing

### 24.Evernote 关闭开机启动

系统偏好设置(左上角苹果图标—系统偏好设置)—用户与群组—选择“启动项” 选择“-”

### 25.mac 安装php7.1

```
brew tap shivammathur/php
brew install shivammathur/php/php@7.1

在.zshrc 添加

export PATH="/usr/local/opt/php@7.1/bin:$PATH"
export PATH="/usr/local/opt/php@7.1/sbin:$PATH"

然后安装扩展 imagemagick

brew install imagemagick

brew instal pkg-config
which pecl
/usr/local/opt/php@7.1/bin/pecl install imagick
```

### 26.laravel 安装包&&移除包

```
php -d memory_limit=-1  composer.phar require simplesoftwareio/simple-qrcode 2.0.0

php -d memory_limit=-1  composer.phar remove guzzlehttp/guzzle 7.4.0 

php -d memory_limit=-1  composer.phar  require hashids/hashids 3.0.0
使用：
use Hashids\Hashids;

$hashids = new Hashids();

$hashids->encode(1);
```

### 27.mac 安装指定版本macos

```
https://support.apple.com/zh-cn/HT211683
```



### 29.PHP 开启一个服务

```
➜  api ll
total 12K
-rw-r--r-- 1 liubing staff  48 2022-03-02 17:02:43 index.php
-rw-r--r-- 1 liubing staff 555 2022-03-02 17:09:02 pic.php
-rw-r--r-- 1 liubing staff 130 2022-03-02 17:02:55 route2.php
➜  api php -c php.ini -S 127.0.0.1:8000 -t /Users/liubing/sai/api
PHP 7.1.33 Development Server started at Wed Mar  2 17:12:38 2022
Listening on http://127.0.0.1:8000
Document root is /Users/liubing/sai/api
Press Ctrl-C to quit.
```

### 30.用 Python 和 Bash 自动上传图片到 GitHub 并生成对应的网址

```
# !/usr/bin/env python3
import pyperclip
import subprocess

# 安装
# brew install fzf
# pip3 install pyperclip


# 请按照实际情况填写
username = "91xcode"
repo_name = "static"
branch_name = "master"

# https://raw.githubusercontent.com/91xcode/static/master/pic/1.png
# https://cdn.jsdelivr.net/gh/91xcode/static@master/pic/1.png


github = f"https://raw.githubusercontent.com/{username}/{repo_name}/{branch_name}/pic/"
jsdeliver = f"https://cdn.jsdelivr.net/gh/{username}/{repo_name}@{branch_name}/pic/"

copy_path = "fzf | tr -d '\n' | pbcopy"


def get_url():
    subprocess.call(copy_path, shell=True)
    path = pyperclip.paste()
    print(f"\n![]({github + path})\n")
    print(f"![]({jsdeliver + path})\n")
    pyperclip.copy(f"![]({jsdeliver + path})")


while True:
    if input("Press Enter to continue. Type something else to quit: ") == "":
        get_url()
    else:
        break
```

### 31.typora批量将md文件转化成html

```
pandoc -s -V theme:Newsprint 定点医院.md -o 定点医院.html 
```

### 32.jsdelivr访问地址

 ```
CloudFlare：test1.jsdelivr.net
CloudFlare：testingcf.jsdelivr.net
Fastly：fastly.jsdelivr.net
GCORE：gcore.jsdelivr.net
 ```

### 33.mac PHP安装mongo扩展

 ```
Macos brew install mongo
提示说没有可用的名叫 monggodb 的模块，真是见鬼了，通过一番了解，才知道，MongoDB 已经宣布不再开源，从2019年9月2日开始 ，HomeBrew 也从核心仓库 (#43770) 当中移除了mongodb 模块

brew tap mongodb/brew
brew install mongodb/brew/mongodb-community@3.6

brew services start mongodb-community@3.6
/usr/local/Cellar/mongodb-community@3.6/3.6.14/bin/mongo 

php7.1.33 安装mongodb扩展 
pecl install https://pecl.php.net/get/mongodb-1.11.1.tgz
 ```

### 34.短信接码

```
国内的：
  supercloudsms.com
  yunduanxin.xyz
  yunjiema.top

国外的:
	free-sms-receive.com
	receive-smss.com

阳子：我用过这个，https://www.storytrain.info/感觉是最良心的，每周都会更新号码

```

### 35.Mac升级10.15 Catalina，根目录无权限 完美解决办法

```
重启电脑，按住 cmd+R 进入恢复模式 点击实用工具===>选择终端
关闭SIP： csrutil disable，然后重启
重新挂载根目录：sudo mount -uw /，接下来划重点：现在已经可以在根目录创建文件夹，但是，你在根目录创建之后，一旦重启电脑，你创建的目录又是只读权限了。所以，正确的做法是把你需要的目录软链接到根目录, 例如： sudo ln -s /usr/local/Cellar/nginx/1.21.6_1/html/data /data
重新进入恢复模式，重新打开SIP： csrutil enable
```

### 36.Big Sur根目录无权限 完美解决办法


```
## 1.vim 修改synthetic.conf（没有会创建）

sudo vim /etc/synthetic.conf
## 2.添加一行记录(使用 tab 进行分割，空格 换行，使用空格分割会发现重启无效)

## 以此处举例

data    /usr/local/Cellar/nginx/1.21.6_1/html/data

## 重启后，就已经生成好了

在根目录下已经创建好 data 软连接到 /usr/local/Cellar/nginx/1.21.6_1/html/data
ls -al
......
lrwxr-xr-x   1 root  wheel    17  7 21 14:45 data -> /usr/local/Cellar/nginx/1.21.6_1/html/data
......
```

### 37.Mac OS Big Sur 挂载ntfs格式的移动硬盘

	由于目前的ntfs tools还不支持Big Sur，本人也实验了很多方法，总结如下：
	首先卸载ntfs tools。
	然后插入ntfs格式的移动硬盘。
	再新建ssd文件夹，然后使用命令行挂载ntfs格式的移动硬盘。具体命令如下：

```
使用diskutil list找到需要挂载的磁盘名，比如我的移动硬盘被mac识别为/dev/disk3s1，然后：
mkdir ~/ssd
sudo mount -t ntfs -o rw,auto,nobrowse /dev/disk2s1 ~/ssd/

最后，使用完卸载硬盘：
sudo umount /dev/disk2s1
```
