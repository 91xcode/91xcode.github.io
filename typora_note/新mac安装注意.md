# 新的Mac 初始安装注意要点

## 需求

>   拿到新电脑 要开始安装常规软件、技术开发环境、电脑使用设置

## 步骤

### 0.系统偏好设置

```
1. 触控板-轻点按来点按
2. 系统偏好设置-输入法—快捷键
3. 输入法—第二个 设置成 commanf+空格键
4. 聚焦——第一个 设置成 control+option+空格键
```

### 1.Brew、软件安装

​		我们访问www.brew.sh：

```shel
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

​		然后vim ~/brew.sh

    #!/bin/bash
    
    # 判断是否为MacOS，是则安装homebrew
    if [ "$(uname)" = "Darwin" ] ; then
      # MacOS
      if ! type brew >/dev/null 2>/dev/null; then
        echo "---start install homebrew---"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      else
        echo "---start upgrade homebrew---"
      fi
    else
      # Linux
      echo "homebrew The missing package manager for macOS"
    fi
    
    # Make sure we’re using the latest Homebrew.
    brew update
    
    # Upgrade any already-installed formulae.
    brew upgrade
    
    # 常用的命令行工具安装
    #brew install vim
    
    #常用的工具包安装
    brew install --cask iterm2
    brew install --cask firefox
    brew install --cask google-chrome
    brew install --cask feishu
    brew install --cask wechat
    brew install --cask evernote
    brew install --cask keka
    brew install --cask sublime-text
    brew install --cask cheatsheet
    brew install --cask goland
    brew install --cask phpstorm
    brew install --cask pycharm
    brew install --cask iina
    brew install --cask vlc
    brew install zsh zsh-completions
    brew install docker
    brew install nginx
    brew install archey
    brew install htop
    brew install redis
    
    brew cleanup

### 2.安装oh-my-zsh

cd ~

git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

～目录下没有.zshrc 3.1   touch .zshrc 3.2   cp ~/.zshrc   ~/.zshrc.orig

创建zsh配置文件 cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc 

配置兼容bash环境变量 .zshrc 文件中添加source ~/.bash_profile 

修改默认shell chsh -s $(which zsh)



### 3.mac终端换行会出现括号

取消：编辑->标记->自动标记提示行

### 4.怎么设置火狐浏览器新标签页为百度

在地址栏输入：about:config搜索browser.newtab.url 右键修改为百度的网址

### 4.Sublime Text 4 如何安装Package Control

Tools==>Install Package Control

然后 Preferences==>Package Control 安装扩展

ConvertToUTF8
HTML-CSS-JS Prettify
SideBarEnhancements


sublime4 左侧没有目录

显示左侧目录呢?我们可以点击菜单栏“view”——“Side Bar”——“shaw side bar”,

### 5.MAC-解决 打不开应用 设置允许任何来源


sudo spctl --master-disable

### 6.iterm2设置Snippets

  

```
找到Preferences > Profiles > Session；
打开Status bar enabled选项；
点击Configure Status Bar，把Snippet拖拉到下面的激活框，然后点击“OK”即可。

颜色选择：kevin.itermcolors
```



### 7.尝试卸载后重新安装，brew install php@7.3 报错Error: php@7.3 has been disabled because it is a versioned formula!

```
  解决
  brew tap shivammathur/php
  brew install shivammathur/php/php@7.3
```



### 8.可以查看当前安装的go版本有哪些，比如当前安装的为go1.15，现在想装一个低版本的如1.12.17。操作如下：

    brew info go
    1. ll /usr/local/bin/go 查看当前go对应的软链
    2. brew search go 查找可用的go版本
    3. brew install go@1.12安装1.12版本
    4. brew unlink go 将当前软链移除
    5. brew link go@1.12指定新的软链
    6. ll /usr/local/bin/go && go env验证修改后的版本

### 9.安装完brew install go 之后 查看环境变量 go env 如果是老版本的话 cd /home 建立mkdir -p go/{src,bin,pkg}

### 10.申请一个新的apple_id

### 11.数据同步 采用隔空投送

### 12.git ssh_key

```
  ssh-keygen -t rsa -C "邮箱"
  pbcopy < ~/.ssh/id_rsa.pub

  如果多ssh key
  ssh-keygen -t rsa -f ~/.ssh/github_id_rsa -C "email"
```

  ➜  .ssh cat config 

       host *
       ControlMaster auto
       ControlPath ~/.ssh/master-%r@%h:%p
       # github
       Host github.com
       HostName github.com
       PreferredAuthentications publickey
       IdentityFile ~/.ssh/github_id_rsa


  pbcopy < ~/.ssh/github_id_rsa.pub

  添加到github ssh key

  ssh -T git@github.com

### 13.Mac升级10.15 Catalina，根目录无权限 完美解决办法

重启电脑，按住 cmd+R 进入恢复模式 点击实用工具===>选择终端
关闭SIP： csrutil disable，然后重启
重新挂载根目录：sudo mount -uw /，接下来划重点：现在已经可以在根目录创建文件夹，但是，你在根目录创建之后，一旦重启电脑，你创建的目录又是只读权限了。所以，正确的做法是把你需要的目录软链接到根目录, 例如： sudo ln -s /usr/local/Cellar/nginx/1.21.6_1/html/data /data
重新进入恢复模式，重新打开SIP： csrutil enable

### 14.Big Sur根目录无法创建文件夹

    ## 1.vim 修改synthetic.conf（没有会创建）
   

    sudo vim /etc/synthetic.conf
    ## 2.添加一行记录(使用 tab 进行分割，空格 换行，使用空格分割会发现重启无效)
    
    ## 以此处举例
    
    data    /usr/local/Cellar/nginx/1.21.6_1/html/data
    
    ## 重启后，在根目录下已经创建好 data 软连接到 /Users/admin/data
    ls -al
    ......
    lrwxr-xr-x   1 root  wheel    17  7 21 14:45 data -> /Users/admin/data
    ......

### 14 git全局log配置

```
git config --global alias.ls "log --no-merges --color --graph --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Cblue %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit"

使用 git ls 或者 git ls -p

git config --global alias.lss "log --no-merges --color --stat --graph --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Cblue %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit"

使用 git lss 或者 git lss -p


查看单个文件的修改历史
git lss -p filename.php

查看指定成员 以及commit 含有的字符串
git lss --author liubing1 --grep '销售' -p
git lss --author liubing1
```



### 15 PHPSTORM去除警告波浪线的方法，IDEA应该也适用

```
  Preferences-Editor-Color Scheme-General-Errors and Warnings

  进入上述说的步骤之后，找到Weak Warnings取消Error stripe mark和Effects勾选，应用保存即可。
```



### 16.alfred 安装扩展 

  https://github.com/91xcode/Alfred-Workflow_List-Processing

### 17.Evernote 关闭开机启动

系统偏好设置(左上角苹果图标—系统偏好设置)—用户与群组—选择“启动项” 选择“-”

### 18.mac 安装php7.1

```
brew tap shivammathur/php
brew install shivammathur/php/php@7.1

在.zshrc 添加

export PATH="/usr/local/opt/php@7.1/bin:$PATH"
export PATH="/usr/local/opt/php@7.1/sbin:$PATH"

然后安装扩展 imagemagick

brew install imagemagick

brew instal pkg-config
which pecl
/usr/local/opt/php@7.1/bin/pecl install imagick
```



### 19.laravel 安装包&&移除包

```
php -d memory_limit=-1  composer.phar require simplesoftwareio/simple-qrcode 2.0.0

php -d memory_limit=-1  composer.phar remove guzzlehttp/guzzle 7.4.0 

php -d memory_limit=-1  composer.phar  require hashids/hashids 3.0.0
使用：
use Hashids\Hashids;

$hashids = new Hashids();

$hashids->encode(1);
```



### 20.mac 安装指定版本macos

```
https://support.apple.com/zh-cn/HT211683
```



### 21.Mac OS Big Sur 挂载ntfs格式的移动硬盘

​	由于目前的ntfs tools还不支持Big Sur，本人也实验了很多方法，总结如下：
​	首先卸载ntfs tools。
​	然后插入ntfs格式的移动硬盘。
​	再新建ssd文件夹，然后使用命令行挂载ntfs格式的移动硬盘。具体命令如下：

    使用diskutil list找到需要挂载的磁盘名，比如我的移动硬盘被mac识别为/dev/disk3s1，然后：
    mkdir ~/ssd
    sudo mount -t ntfs -o rw,auto,nobrowse /dev/disk2s1 ~/ssd/
    
    最后，使用完卸载硬盘：
    sudo umount /dev/disk2s1

### 22.PHP 开启一个服务

```
➜  api ll
total 12K
-rw-r--r-- 1 liubing staff  48 2022-03-02 17:02:43 index.php
-rw-r--r-- 1 liubing staff 555 2022-03-02 17:09:02 pic.php
-rw-r--r-- 1 liubing staff 130 2022-03-02 17:02:55 route2.php
➜  api php -c php.ini -S 127.0.0.1:8000 -t /Users/liubing/sai/api
PHP 7.1.33 Development Server started at Wed Mar  2 17:12:38 2022
Listening on http://127.0.0.1:8000
Document root is /Users/liubing/sai/api
Press Ctrl-C to quit.
```

### 23.用 Python 和 Bash 自动上传图片到 GitHub 并生成对应的网址

```
# !/usr/bin/env python3
import pyperclip
import subprocess

# 安装
# brew install fzf
# pip3 install pyperclip


# 请按照实际情况填写
username = "91xcode"
repo_name = "static"
branch_name = "master"

# https://raw.githubusercontent.com/91xcode/static/master/pic/1.png
# https://cdn.jsdelivr.net/gh/91xcode/static@master/pic/1.png


github = f"https://raw.githubusercontent.com/{username}/{repo_name}/{branch_name}/pic/"
jsdeliver = f"https://cdn.jsdelivr.net/gh/{username}/{repo_name}@{branch_name}/pic/"

copy_path = "fzf | tr -d '\n' | pbcopy"


def get_url():
    subprocess.call(copy_path, shell=True)
    path = pyperclip.paste()
    print(f"\n![]({github + path})\n")
    print(f"![]({jsdeliver + path})\n")
    pyperclip.copy(f"![]({jsdeliver + path})")


while True:
    if input("Press Enter to continue. Type something else to quit: ") == "":
        get_url()
    else:
        break
```

### 24.typora批量将md文件转化成html

```
pandoc -s -V theme:Newsprint 定点医院.md -o 定点医院.html 
```

