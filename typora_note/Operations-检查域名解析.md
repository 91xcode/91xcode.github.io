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
