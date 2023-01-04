@[TOC](这里写自定义目录标题)

# **端口检查**



服务器上运行了一个服务，想测试一下端口通不通，可以通过以下一些方法来测试。

## telnet

常见的tcp端口测试都是用的telnet，用法也很简单

```
telnet 10.0.0.7 22 
```

成功会显示：

```
Trying 10.0.0.7... Connected to 10.0.0.7. Escape character is '^]'. SSH-2.0-OpenSSH_7.4 
```

失败会显示：

```
Trying 10.0.0.7... telnet: Unable to connect to remote host: Connection refused 
```

## ssh

使用

```
ssh root@localhost -p 8000 
```

失败会显示

```
ssh: connect to host localhost port 8001: Connection refused 
```

## curl

curl ip:port

失败会显示

```
curl: (7) Failed to connect to localhost port 8001: Connection refused 
```

## netcat

下面的命令会检查远程主机上是否打开了端口 80、22 和 9000：

```
nc -zv 192.168.2.1 80 22 9000 
```

也可以指定端口扫描的范围(速度非常快)：

```
nc -zv 192.168.2.1 20-9000
```



---



# linux进程和端口查看

#### 1. 根据进程名查看进程信息，以查看tomcat进程名为例

```perl
ps  -ef | grep {programName}
复制代码
```



![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/3/29/169c951b4aeb85bd~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.image)



#### 2.根据进程PID 查看进程信息

```perl
ps -ef | grep {PID}
复制代码
```



![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/3/29/169c95da0f198a2b~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.image)



#### 3. 根据端口查看对应进程

```perl
netstat -tunlp | grep {port}
复制代码
```



![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/3/29/169c95a83753bfa6~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.image)



#### 4. 查看进程PID占用端口情况

```perl
netstat -nap | grep {PID}
复制代码
```



![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/3/29/169c9591a6b0d08b~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.image)



#### 5. `ps -ef 和ps -aux`区别



![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/3/29/169c9c015bec3513~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.image)



```objectivec
UID     用户ID、但输出的是用户名   
PID     进程的ID 
PPID    父进程ID   
C       进程占用CPU的百分比   
STIME   进程启动到现在的时间   
TTY    该进程在那个终端上运行，若与终端无关，则显示?  
CMD    命令的名称和参数
复制代码
```



![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/3/29/169c9bf51161ce8d~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.image)



```sql
USER      用户名  
%CPU      进程占用的CPU百分比  
%MEM      占用内存的百分比    
VSZ       该进程使用的虚拟內存量（KB）   
RSS       该进程占用的固定內存量（KB）（驻留中页的数量）   
STAT      进程的状态   
START     该进程被触发启动时间    
TIME      该进程实际使用CPU运行的时间  
复制代码
```

------

```
注意使用场景:`
 `看进程的CPU占用率和内存占用率，可以使用aux`
 `看进程的父进程ID和完整的COMMAND命令，可以使用ef
```





```
Linux通过PID查看进程完整信息

ll /proc/PID
```



`cwd`符号链接的是进程运行目录；

`exe`符号连接就是执行程序的绝对路径；

`cmdline`就是程序运行时输入的命令行命令；

`environ`记录了进程运行时的环境变量；

`fd`目录下是进程打开或使用的文件的符号连接。