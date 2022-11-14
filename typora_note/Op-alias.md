@[TOC](这里写自定义目录标题)

# Alias

## 需求

>   alias日常使用备注





```zsh


#设置my_zsh_env
export TERM=xterm 
#禁用scan-构建完镜像本地有时会报错 Use ‘docker scan’ to run Snyk tests against images to find vulnerabilities and learn how to fix them
export DOCKER_SCAN_SUGGEST=false
#禁止brew自动更新 
export DISABLE_AUTO_UPDATE=true


#Productivity

archey

alias cp='cp -i'


alias v.='vim ~/.zshrc'
alias s.='source ~/.zshrc && echo "Reload OK!"'

#新增加的alias
alias toup='test() { echo $1 | tr "a-z" "A-Z" };test'
alias tolow='test() { echo $1 | tr 'A-Z' 'a-z' };test'

alias copypwd='test(){ pwd | pbcopy};test'
alias copyfile='test(){ cat $1 | pbcopy};test'

#backup [文件] 将会在同一个目录下创建 [文件].bak
backup() { cp "$1"{,.bak};}



#Mac显示当前目录的大小
function sbs(){  du -hd1 | perl -e 'sub h{%h=(K=>10,M=>20,G=>30);($n,$u)=shift=~/([0-9.]+)(\D)/;
return $n*2**$h{$u}}print sort{h($b)<=>h($a)}<>;'}
(($+commands[sbs])) || alias sbs=sbs


alias admin-token='test(){ printf $(sh /Users/sai/tools/shell_dir/adm_access_token.sh) | pbcopy};test'


#66测试环境
alias login66mysql='mysql -h 10.60.81.66 -uroot -p123456 -A'    #mysql
alias login66redis="redis-cli -h 10.60.81.66 -p 6379 -a '123456'"


alias rgf='rg --files | rg'


# ls for mac
#alias ll='ls -al'   #ls相关，这里--color需要根据终端设
alias lx='ls -lhBX'        #sort by extension
alias lz='ls -lhrS'        #sort by size
alias lt='ls -lhrt'        #sort by date    最常用到，ls -rt，按修改时间查看目录下文件
alias lsd='find . -maxdepth 1 -type d | sort'   #列出所有目录

# net
alias pong='ping -c 5 '   #ping，限制
alias ports='netstat -tulanp'
alias myip='curl ifconfig.me'

alias size='f(){ du -sh $1* | sort -hr; }; f'
alias count='ls -1 | wc -l'
alias now='date "+%Y-%m-%d %H:%M:%S"'


alias killport='test() { sudo kill $(sudo lsof -t -i:$1) };test'  # killport 12345
# 下面是查看端口进程
alias lsofi='test() { sudo lsof -i :$1 };test'  # 得到的是 PID, 交给下面 psfp 处理, 用 sudo, 否则显示不全
alias psfp='ps -fp'  # psfp 25 查看 25 号 PID 的程序
alias psfplsofi='test() { sudo ps -fp $(sudo lsof -t -i :$1) };test'

alias qkills="test() { ps -ef | grep $1 | awk '{print $2}' | sudo xargs kill -9 };test"  # qkill python # -elf 会显示好多不需要的进程


alias myip="ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d 'addr:'"


# Bash into running container
alias dockerin='test(){ docker exec -it $(docker ps -aqf "name=$1") bash;};test'


#Network
alias websiteget="wget --random-wait -r -p -e robots=off -U mozilla"    #  下载整个网站，usage：websiteget [URL]
alias listen="lsof -P -i -n"              #  显示出哪个应用程序连接到网络
alias port='netstat -tulanp'           #  显示活动的端口
alias ipinfo="curl ifconfig.me && curl ifconfig.me/host"    #  获取你的公网ip地址和主机名
getlocation() { lynx -dump http://www.ip-adress.com/ip_tracer/?QRY=$1|grep address|egrep 'city|state|country'|awk '{print $3,$4,$5,$6,$7,$8}'|sed 's\ip address flag \\'|sed 's\My\\';}           #  返回你当前ip地址的地理位置

 
 
 
```



