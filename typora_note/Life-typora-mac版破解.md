@[TOC](这里写自定义目录标题)

主页: [link](https://bbs.kanxue.com/thread-273420.htm).

# Typora mac版破解

## 前言

请勿使用盗版，支持正版授权。
文中内容仅作学习和讨论，请不要从事任何非法行为。
由此产生的任何问题都将读者/用户（您）承担。

 

先说结论：破解点很简单，只改了js代码的一个判断条件（不看分析可以直接看第四点），这里分享我的分析流程。
本帖使用目前最新版typora：1.3.7 (6424)

## 一、寻踪觅源

一开始想尝试查看typora的运行日志，看看日志有无license的验证过程，然而发现我找不到；
运行typora，打开活动监视器，查看typora操作了哪些文件

![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_KNNTGMD5SH8HT8T-20231218181204043.png)

 

疑似的两个日志文件：
![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_43RGGG43UVPXXQY-20231218175947265.png)

![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_UD3PBD5XPKBZTGP-20231218175947766.png)





实际分析发现不是我们想要的。
进一步在系统目录尝试了寻找有无typora相关的文件：
`find /Library -name Typora`
仍然没有，既然找不到记录日志，就换个思路。

## 二、渐入佳境

之前分析过windows的terminus、typora，猜测很有可能license在js代码里验证，所以直接在Typora.app 全局搜索license字段试试：
显示包内容 -> 目录Contents/Resources/TypeMark -> 拖进vscode搜索：
（稍微熟悉点app的包结构的话，应该知道js代码应该在资源目录下，然后分析一下会发现TypeMark是一个可疑地目录）


![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_GWBSCQ5SDK4NCFD-20231218175948505.png)

发现找到139个文件，也没法一个一个看，还得换个思路。

 

进入typora，弹出购买窗口，点击购买，获取购买链接字符串:

 

![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_H5D5VTHWBJ3DAFA-20231218175957764.png)

![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_YFFYN44B9YPQW9P-20231218175957917.png)




尝试全局搜索购买链接的字符串`https://store.typora.io/`，发现还真有：

![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_A8T75U5G52UVMTW-20231218175958775.png)

一看文件名license，大概率是这个文件。

## 三、柳暗花明

vscode打开该文件：

![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_P74VCB8MZMEZ4TW-20231218180000661.png)

需要先安装插件格式化js，这个不赘述了，格式化后如下：

![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_VF9KUZQVG4G6Z58-20231218180002332.png)

接下来分析下js代码（我大多数时候看直觉）：
链接字符串上下文代码大致是用来创建html元素，好像没什么用，只是知道购买弹窗确实是这一部分代码：

![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_WR5GDXYCPX72G44-20231218180004880.png)

 再往下看几行代码发现可疑地一些函数：
`useState` 函数可能是用户的使用状态；
`hasActivated` 变量可能是是否被激活；

![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_55H9FXDWFF3AZ56-20231218180009549.png)

那么就去看一下 `hasActivated`的定义，发现如下：
![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_QVRA3KCGQYSD57V-20231218180011083.png)

 

`=` 赋值语句
`==` 判断语句，判断值是否相等
尝试修改：`e.hasActivated = "true" == "true"`
成功。

![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_K54WDU5KRSH3CRB-20231218180014787.png)

## 四、落叶归根

只需要将文件
`Typora.app/Contents/Resources/TypeMark/page-dist/static/js/LicenseIndex.180dd4c7.5dc16d09.chunk.js`
这一行代码
`e.hasActivated = "true" == e.hasActivated`

![图片描述](https://cdn.jsdelivr.net/gh/91xcode/typora_img/img/typora/726474_CG7WXR25HYWCN99-20231218180015127.png)


改为
`e.hasActivated = "true" == "true"`
保存即可。

## 尾声

字符串加密还是很有用的。



https://bbs.kanxue.com/thread-273420.htm
