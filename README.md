```




1.免费CDN：jsDelivr+Github 使用方法

	地址:https://www.jsdelivr.com/github

	https://cdn.jsdelivr.net/gh/你的用户名/你的仓库名@发布的版本号/文件路径

	https://cdn.jsdelivr.net/gh/91xcode/static@1.0/m3u8-downloader/vue.js 

	或者 

	https://cdn.jsdelivr.net/gh/91xcode/static@master/m3u8-downloader/vue.js

	刷新

	https://purge.jsdelivr.net/gh/91xcode/static@master/m3u8-downloader/vue.js

	


2.使用git config --global设置用户名和邮件

	git config  user.name "liu.local" 
	git config user.email "xx@qq.com" 


	注意 git config命令的–global参数，用了这个参数，表示你这台机器上所有的Git仓库都会使用这个配置，当然也可以对某个仓库指定不同的用户名和Email地址。

	配置好之后可以使用

	git config -l

	查看配置

3.Mac清除DNS缓存命令
	sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say flushed

```