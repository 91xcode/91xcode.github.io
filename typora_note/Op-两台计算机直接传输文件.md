@[TOC](这里写自定义目录标题)

# **两台计算机直接传输文件**



这里的计算机指的是广义上的计算机，包括但不限于家用电脑、服务器、手机、树莓派等等

## scp

>   scp 使用的是SSH端口

```
# 拷贝本地文件testfile到192.168.1.100的/tmp目录下 
scp testfile root@192.168.1.100:/tmp 

# 拷贝本地文件夹到192.168.1.100的/tmp目录下 
scp -r testfolder root@192.168.1.100:/tmp 

# 拷贝远程到本地 
scp root@192.168.1.100:/tmp/testfile . 

```

## ftp

>   ftp控制端口是21，用于账号密码认证以及协商端口等。
>   主动模式：数据端口是20
>   被动模式：客户端可服务端协商一个端口

使用Python简单搭建一个ftp服务器

```
pip3 install pyftpdlib 
python3 -m pyftpdlib -p 21 
```

## sftp

>   sftp 是安全的ftp，走的是SSH协议

### sftp常用命令

| 命令                        | 功能                              |
| --------------------------- | --------------------------------- |
| cd path                     | Change remote directory to ‘path’ |
| get [-afpR] remote [local]  | Download file                     |
| help                        | Display this help text            |
| lcd path                    | Change local directory to ‘path’  |
| lls [ls-options [path]]     | Display local directory listing   |
| lmkdir path                 | Create local directory            |
| ln [-s] oldpath newpath     | Link remote file (-s for symlink) |
| lpwd                        | Print local working directory     |
| ls [-1afhlnrSt] [path]      | Display remote directory listing  |
| mkdir path                  | Create remote directory           |
| put [-afpR] local [remote]  | Upload file                       |
| pwd                         | Display remote working directory  |
| reget [-fpR] remote [local] | Resume download file              |
| reput [-fpR] local [remote] | Resume upload file                |
| rm path                     | Delete remote file                |
| rmdir path                  | Remove remote directory           |

```
sftp root@192.168.1.100 # 可以用cd ls等命令，找到文件后使用get下载 get testfile 
```

## rsync

### 使用ssh协议传输

```
rsync -avz source/ user@remote_host:/destination 
```

如果ssh有其他参数，需要特殊指定

```
rsync -avz -e 'ssh -p 2234' source/ user@remote_host:/destination 
```

### 使用rsync协议传输

>   使用rsync协议需要对方安装rsync守护程序

使用rsync://协议（默认端口873）进行传输。具体写法是服务器与目标目录之间使用双冒号分隔::。

```
rsync -av source/ 192.168.122.32::module/destination 
```

注意，上面地址中的module并不是实际路径名，而是 rsync 守护程序指定的一个资源名，由管理员分配。

如果想知道 rsync 守护程序分配的所有 module 列表，可以执行下面命令。

```
rsync rsync://192.168.122.32 
```

rsync 协议除了使用双冒号，也可以直接用rsync://协议指定地址。

```
rsync -av source/ rsync://192.168.122.32/module/destination 
```

### 排除

```
rsync -av --exclude "snapshot" /var/lib/cass ./bak/ 
```

## http

使用python搭建一个简单的http服务

```
python -m http.server 
```

## nc

优点：方便、可以使用udp端口被进行传输

在服务器上执行

```
nc -l 1234      # 监听tcp 1234端口 nc -lu 1234     # 监听udp 1234端口 
```

在客户端执行

```
nc 10.0.0.131 1234      # 通过tcp连接服务器 nc 10.0.0.131 -u 1234   # 通过udp连接服务器 
```

连接上后，在控制台输入文字，服务器端会显示

同样的，可以把控制台的数据重定向到文件，就可以实现文件的传输了

接受文件端：

```
nc -l 1234 > file.txt 
```

传送文件端：

```
nc 10.0.0.131 1234 < file.txt 
```

## smb或nfs等

[搭建NFS服务](https://zahui.fan/4b677f68)

## lrzsz

lrzsz 可以在连接终端的时候直接进行文件传输，比较方便，但是对终端有要求，在windows端有xshell可以支持，Linux中kde的konsole可以支持。lrzsz速度没有scp快，但是在连接了ssh的时候比较方便。比较适合传输小文件，大文件会比较容易出错。

xshell甚至可以直接拖文件到终端窗口完成上传操作

远程服务器安装包

```
yum install -y lrzsz 
```

上传文件：

```
rz 
```

下载文件：

```
sz testfile 
```

## 直接使用SSH加管道来传输

>   大家知道Linux管道可以传输数据，如果管道和SSH配合使用的话，也可以达到传输文件的效果，比如：

```
cat jianguoyun.net.cn.crt | ssh iuxt@10.0.0.9 "cd /tmp && cat > 1.txt" 
```

这样就是把主机上的jianguoyun.net.cn.crt文件传输到10.0.0.9的tmp/1.txt里面了。

还可以配合tar实现边压缩边传输：

```
tar zcv testfolder -f - | ssh iuxt@10.0.0.9 "cd /tmp && tar zxf -"
```
