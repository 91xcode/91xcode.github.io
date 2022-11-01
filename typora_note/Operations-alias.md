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

#export DISABLE_AUTO_UPDATE="true"

#新增加的alias
alias toup='test() { echo $1 | tr "a-z" "A-Z" };test'
alias tolow='test() { echo $1 | tr 'A-Z' 'a-z' };test'

#66测试环境
alias login66mysql='mysql -h host -uroot -p123456 -A'    #mysql
alias login66redis="redis-cli -h host -p 6379 -a '123456'"


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
 
 
 
```
