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