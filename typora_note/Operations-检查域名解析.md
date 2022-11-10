

@[TOC](这里写自定义目录标题)

# **检查域名解析**



## dig

### 安装

```
apt-get install dnsutils

yum install bind-utils
```

### 查询

```

解析到国内
dig auth.vipthink.cn @114.114.114.114 

解析到海外
dig auth.vipthink.cn @8.8.8.8

```

## nslookup

```
nslookup baidu.com 114.114.114.114 
nslookup baidu.com
```

## 详解

```bash
#!/bin/bash
##################################################################
## 1. nslookup 交互式地查询域名记录
##################################################################
nslookup facebook.github.io  # 或者先输入 nslookup, 然后交互式输入 URL
##################################################################
## 2. dig 阮一峰 DNS 原理入门
##################################################################
dig math.stackexchange.com  # 会输出六段信息
# 第一段是查询参数和统计
# ; <<>> DiG 9.10.3-P4-Ubuntu <<>> math.stackexchange.com
# ;; global options: +cmd
# ;; Got answer:
# ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 17428
# ;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 4, ADDITIONAL: 5

# 第二段是查询内容
# ;; OPT PSEUDOSECTION:
# ; EDNS: version: 0, flags:; udp: 4096
# ;; QUESTION SECTION:
# ;math.stackexchange.com.                IN      A
# 上面结果表示, 查询域名 math.stackexchange.com 的 A 记录, A 是 address 的缩写

# 第三段是 DNS 服务器的答复
# ;; ANSWER SECTION:
# math.stackexchange.com. 300     IN      A       151.101.1.69
# math.stackexchange.com. 300     IN      A       151.101.65.69
# math.stackexchange.com. 300     IN      A       151.101.193.69
# math.stackexchange.com. 300     IN      A       151.101.129.69
# 上面结果显示, math.stackexchange.com 有四个A记录, 即四个 IP 地址; 300 是 TTL 值(Time to live 的缩写), 表示缓存时间, 即 600 秒之内不用重新查询

# 第四段显示 stackexchange.com 的 NS 记录(Name Server的缩写), 即哪些服务器负责管理 stackexchange.com 的 DNS 记录
# ;; AUTHORITY SECTION:
# stackexchange.com.      169071  IN      NS      ns-1832.awsdns-37.co.uk.
# stackexchange.com.      169071  IN      NS      ns-1029.awsdns-00.org.
# stackexchange.com.      169071  IN      NS      ns-925.awsdns-51.net.
# stackexchange.com.      169071  IN      NS      ns-463.awsdns-57.com.
# 上面结果显示 stackexchange.com 共有四条 NS 记录, 即四个域名服务器, 向其中任一台查询就能知道 math.stackexchange.com 的 IP 地址是什么

# 第五段是上面四个域名服务器的 IP 地址, 这是随着前一段一起返回的
# ;; ADDITIONAL SECTION:
# ns-1029.awsdns-00.org.  137867  IN      A       205.251.196.5
# ns-1832.awsdns-37.co.uk. 138175 IN      A       205.251.199.40
# ns-463.awsdns-57.com.   139003  IN      A       205.251.193.207
# ns-925.awsdns-51.net.   139538  IN      A       205.251.195.157

# 第六段是 DNS 服务器的一些传输信息
# ;; Query time: 265 msec
# ;; SERVER: 127.0.1.1#53(127.0.1.1)
# ;; WHEN: Fri Dec 02 09:44:42 CST 2016
# ;; MSG SIZE  rcvd: 316
# 上面结果显示, 本机的 DNS 服务器是 127.0.1.1, 查询端口是 53(DNS服务器的默认端口), 以及回应长度是 316 字节

dig +trace math.stackexchange.com  # 会有两段显示
# 第一段列出根域名.的所有NS记录, 即所有根域名服务器
# 根据内置的根域名服务器IP地址, DNS服务器向所有这些IP地址发出查询请求, 询问math.stackexchange.com的顶级域名服务器com.的NS记录。最先回复的根域名服务器将被缓存, 以后只向这台服务器发请求
# ; <<>> DiG 9.10.3-P4-Ubuntu <<>> +trace math.stackexchange.com
# ;; global options: +cmd
# .                       481638  IN      NS      l.root-servers.net.
# .                       481638  IN      NS      d.root-servers.net.
# .                       481638  IN      NS      k.root-servers.net.
# .                       481638  IN      NS      g.root-servers.net.
# .                       481638  IN      NS      c.root-servers.net.
# .                       481638  IN      NS      a.root-servers.net.
# .                       481638  IN      NS      h.root-servers.net.
# .                       481638  IN      NS      e.root-servers.net.
# .                       481638  IN      NS      j.root-servers.net.
# .                       481638  IN      NS      b.root-servers.net.
# .                       481638  IN      NS      i.root-servers.net.
# .                       481638  IN      NS      m.root-servers.net.
# .                       481638  IN      NS      f.root-servers.net.
# .                       518400  IN      RRSIG   NS 8 0 518400 20161214170000 20161201160000 39291 . FF1AcmQKRPTMrEy5U5gaOhoO+7dk6sUB1SdzGWlt8bkXhqVY5kNnwmVG Nk3YsJWXKlI104HGbIZPwqA1btyokO9svD+zkqwtwbAPIXF741djW42/ EQEpl89OTTz8L0m4WYVUAdn6rSFKxcPlL/16DGmuhCJMTe2sBeGipN3u Bo06uZT7P5A60vi0+m7wq3Ymw+Ra8mlajZ+cDndL/sXs6M6QGn0Y0o6b A28UVf8nwsULhmu4jge5QBRaEfnGVJf6oX93bvbLJCfRpc0yEbPVBeO9 wozWRbFqs82vyO9SzHAUJfnnkdz93bKhu8Y3F+Rs3tetbO/0YPjG4S65 /IaUvg==
# ;; Received 1097 bytes from 127.0.1.1#53(127.0.1.1) in 1 ms

# 接着第二段
# ;; ANSWER SECTION:
# com.                    133713  IN      NS      a.gtld-servers.net.
# com.                    133713  IN      NS      f.gtld-servers.net.
# com.                    133713  IN      NS      b.gtld-servers.net.
# com.                    133713  IN      NS      e.gtld-servers.net.
# com.                    133713  IN      NS      l.gtld-servers.net.
# com.                    133713  IN      NS      g.gtld-servers.net.
# com.                    133713  IN      NS      d.gtld-servers.net.
# com.                    133713  IN      NS      m.gtld-servers.net.
# com.                    133713  IN      NS      c.gtld-servers.net.
# com.                    133713  IN      NS      k.gtld-servers.net.
# com.                    133713  IN      NS      j.gtld-servers.net.
# com.                    133713  IN      NS      i.gtld-servers.net.
# com.                    133713  IN      NS      h.gtld-servers.net.
# 然后, DNS服务器向这些顶级域名服务器发出查询请求, 询问math.stackexchange.com的次级域名stackexchange.com的NS记录。
# 然后, DNS服务器向上面这四台NS服务器查询math.stackexchange.com的主机名, 这里省去了

dig coder352.github.com +nostats +nocomments +nocmd
dig +short math.stackexchange.com
# 只返回math.stackexchange.com对应的4个IP地址 (即A记录)
# 151.101.129.69
# 151.101.65.69
# 151.101.193.69
# 151.101.1.69

dig @8.8.8.8 math.stackexchange.com  # 指定 DNS 服务器
dig ns com
dig ns stackexchange.com  # 单独查看每一级域名的NS记录
dig +short ns com
dig +short ns stackexchange.com  # +short 参数可以显示简化的结果
dig -x 192.30.252.153  # 反查域名 153.252.30.192.in-addr.arpa. 3600 IN    PTR pages.github.com.
# 上面结果显示, 192.30.252.153这台服务器的域名是pages.github.com, 逆向查询的一个应用, 是可以防止垃圾邮件, 即验证发送邮件的IP地址, 是否真的有它所声称的域名

# dig命令可以查看指定的记录类型
dig a github.com
dig ns github.com
dig mx github.com
##################################################################
## 2.1 记录类型
# 1. A: 地址记录 (Address) , 返回域名指向的IP地址。
# 2. NS: 域名服务器记录 (Name Server) , 返回保存下一级域名信息的服务器地址。该记录只能设置为域名, 不能设置为IP地址。
# 3. MX: 邮件记录 (Mail eXchange) , 返回接收电子邮件的服务器地址。
# 4. CNAME: 规范名称记录 (Canonical Name) , 返回另一个域名, 即当前查询的域名是另一个域名的跳转, 详见下文。
# 5. PTR: 逆向查询记录 (Pointer Record) , 只用于从IP地址查询域名, 详见下文。
dig facebook.github.io  # facebook.github.io.     2775    IN      CNAME   github.map.fastly.net.
##################################################################
## 2.2 安恒杯
# Tips:域名的 NS dns.flag.sec.edu-info.edu.cn 当前 IP 地址为 202.112.26.110
# edns-client-subnet
dig @202.112.26.110 get.flag.sec.edu-info.edu.cn txt +subnet=8.8.8.8
##################################################################
## 3. host 命令可以看作 dig 命令的简化版本, 返回当前请求域名的各种记录; whois 命令用来查看域名的注册情况
host github.com
# github.com has address 192.30.252.121
# github.com mail is handled by 5 ALT2.ASPMX.L.GOOGLE.COM.
# github.com mail is handled by 10 ALT4.ASPMX.L.GOOGLE.COM.
# github.com mail is handled by 10 ALT3.ASPMX.L.GOOGLE.COM.
# github.com mail is handled by 5 ALT1.ASPMX.L.GOOGLE.COM.
# github.com mail is handled by 1 ASPMX.L.GOOGLE.COM.
host 192.30.252.153  # host 命令也可以用于逆向查询, 即从 IP 地址查询域名, 等同于 dig -x <ip>
whois github.com
```



其他

```bash

nslookup
dig, host, nslookup 都是 DNS 查询工具。nslookup 是最久远的，也是过时的。

nslookup -type=type domain [dns-server]

一般常用的就是 nslookup online.windard.com 或者 nslookup online.windard.com 8.8.8.8

host
根据域名查询 ip 的参数是和 nslookup 一样的 host -t type domain [dns-server]

常用命令示例 host -t aaaa www.windard.com, host windard.com 8.8.8.8, host -t cname status.windard.com

不过，它还可以根据 ip 查询域名 host ip

比如 host 8.8.8.8

dig
常用的 DNS 类型

类型	目的
A	域名对应的 IPv4 地址
AAAA	域名对应的 IPv6 地址
CNAME	如果需要将域名指向另一个域名，可以做 CNAME 指定，并不会做真实跳转，只是作为替代
MX	如果需要设置邮箱，需要设置 MX 记录
NS	如果需要将子域名交给其他 DNS 服务器解析，需要设置 NS 记录
TXT	一般 TXT 作为SPF，反垃圾邮件
SOA	查找域内的SOA地址
dig 是最常用的 DNS 记录查询工具，主要参数也还是 DNS 类型和指定的 DNS 服务器 dig [type] domain [dns-server]

但是它的返回值就非常的详细了,可以加上 +short 来获取简化记录，只有结果。

如果想要更详细的记录，可以加上 +trace 返回查询链路上的每一步。

在 CentOS 中通过 yum install bind-utils 安装，😭，竟然默认没有带。

常用命令 dig status.windard.com @8.8.8.8 +short, dig +short chatroom.windard.com, dig status.windard.com, dig aaaa windard.com

也可以根据 ip 查询域名 dig +x ip

比如 dig -x 202.182.110.237

dig 返回信息
$ dig status.windard.com

; <<>> DiG 9.10.6 <<>> status.windard.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 30897
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;status.windard.com.    IN  A

;; ANSWER SECTION:
status.windard.com. 99  IN  CNAME stats.uptimerobot.com.
stats.uptimerobot.com.  99  IN  A 192.169.82.114

;; Query time: 68 msec
;; SERVER: 10.93.192.1#53(10.93.192.1)
;; WHEN: Tue Jun 30 14:56:26 CST 2020
;; MSG SIZE  rcvd: 95
返回结果中主要分为五个部分

第一部分显示 dig 命令的版本和输入的参数。即返回值的前两行
第二部分显示服务返回的一些技术详情，比较重要的是 status。如果 status 的值为 NOERROR 则说明本次查询成功结束。返回值第一段的后三行。
第三部分中的 “QUESTION SECTION” 显示我们要查询的域名。
第四部分的 “ANSWER SECTION” 是查询到的结果。这里查询到两个结果，递归溯源，从 CNAME 查到了 A 记录。
第五部分则是本次查询的一些统计信息，比如用了多长时间，查询了哪个 DNS 服务器，在什么时间进行的查询等等。
```

