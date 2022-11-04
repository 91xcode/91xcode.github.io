@[TOC](这里写自定义目录标题)

# [Mac中使用brew安装指定版本软件包](https://segmentfault.com/a/1190000015346120)

## 需求

>   以 Typora 为例
>   brew中当前默认为Typora最新付费版本 v1.1.5
>   然而，我们需要 v0.11.18 免费版本

## 步骤

### 1. 查看软件包安装来源

```shell
brew info typora
```

执行上述命令您会得到如下信息：

```shell
https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/typora.rb
```

你看到了什么？github(版本控制) 还有 *.rb(安装文件)

### 2. Github中查看rb文件历史提价(版本)信息

复制链接到地址栏：[https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/typora.rb](https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/typora.rb)
可以看到如下信息：

```mipsasm
cask "typora" do
  version "1.1.5"
  sha256 "fa8a19811ad6a95973e5e15be1f9e645afc5c4769df048a93e58b652527deb81"

  url "https://download.typora.io/mac/Typora-#{version}.dmg"
```

可以看到当前版本就是： typora-1.1.5
**接着，在Github上查看历史提交信息，按照如下操作依次点击(熟悉github的同学应该已经看透了秘密)：**

1.  **点击 History**： 查看历史提交列表
2.  **查找 FFmpeg: 0.11.18，并点击**： 找到我们需要的版本
3.  **点击 View at this point in the history：查看当前版本下的typora.rb完整文件
4.  **点击 Raw** : 查看typora.rb源文件，复制地址栏网址(这一步是不是不需要了，3中的网址应该也可以？我没有尝试)

### 3. 安装 typora-0.11.18 版本软件包

>   typora-0.11.18 对应的typora.rb文件网址：[https://raw.githubusercontent.com/Homebrew/homebrew-cask/e3663ead2edd988dd14e736ce0bb87093729947f/Casks/typora.rb](https://raw.githubusercontent.com/Homebrew/homebrew-cask/e3663ead2edd988dd14e736ce0bb87093729947f/Casks/typora.rb)

**执行安装**

```shell
brew install --cask https://.../typora.rb(上面复制的网址)
```

如果出现

```bash
Error: Calling Non-checksummed download of sshpass formula file from an arbitrary URL is disabled! Use 'brew extract' or 'brew create' and 'brew tap-new' to create a formula file in a tap on GitHub instead.
```

解决办法：
```shell
wget https://.../typora.rb(上面复制的网址)
brew install --cask https://.../typora.rb(上面复制的网址)

```

耐心的等待成功的到来...