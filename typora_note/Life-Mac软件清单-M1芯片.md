@[TOC](这里写自定义目录标题)                           

# 1.从 Windows 到 macOS    Mac 软件清单

>   M1 芯片，Apple Silicon，aarch64 (ARMv8)
>   M1 < M1 Pro < M1 Max
>   MacBook Pro 14 A2442

## 1.1 系统

-   [Mac 键盘快捷键](https://support.apple.com/zh-cn/HT201236)

-   [反转鼠标-scrollreverser](https://pilotmoon.com/scrollreverser/)

-   [macOS终端常用命令大全](https://macwk.com/article/macos-terminal)

    >   [mac shell终端编辑命令行快捷键——行首，行尾Ctrl](https://www.cnblogs.com/cina33blogs/p/8608473.html)

-   [如果您需要在 Mac 上安装 Rosetta](https://support.apple.com/zh-cn/HT211861)

-   Command Line Tools (CLT) for Xcode:

    >   `xcode-select --install`
    >   https://developer.apple.com/downloads or [Xcode 3](https://itunes.apple.com/us/app/xcode/id497799835)

-   Homebrew（已原生支持M1）

    >   https://brew.sh/index_zh-cn.html
    >   https://docs.brew.sh/Installation#macos-requirements
    >   [Homebrew镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/)

    ```bash
    #/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    /usr/bin/ruby -e "$(curl -fsSL https://cdn.jsdelivr.net/gh/ineo6/homebrew-install/install)"
     
    #echo export PATH=/opt/homebrew/bin:$PATH >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    echo 'export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"' >> ~/.zprofile
    source ~/.zprofile
    ```

    >   如果需要同时安装arm版和x86版homebrew，可参考:[M1芯片Mac搭建ios开发环境踩坑](https://mirari.cc/2021/07/28/M1芯片Mac搭建ios开发环境踩坑/)

-   安装`jq`命令：`brew install jq`

-   [防火墙:Scudo 2.0.3 中文破解版（已原生支持M1）](https://macwk.com/soft/scudo)

-   [iStat Menus(优秀的系统监控工具)（已原生支持M1）](https://www.macwk.com/soft/istat-menus)

-   [【开源】Stats 2.6.17 中文版 (菜单栏系统监视器)（已原生支持M1）](https://macwk.com/soft/stats)

-   [Network & Battery 12.4.2 中文破解版 (实时网速显示及电池健康)（已原生支持M1）](https://macwk.com/soft/network-and-battery)

    >   商店25元，https://apps.apple.com/cn/app/id1387780159

-   [Bartender 4 4.1.18 中文破解版 (方便的管理菜单栏图标) （已原生支持M1）](https://macwk.com/soft/bartender-4)

-   [BetterTouchTool 3.678 中文破解版 (超强鼠标触控板增强)（已原生支持M1）](https://macwk.com/soft/bettertouchtool)

    >   [MAC上最强鼠标——Magic Mouse2使用指南](https://zhuanlan.zhihu.com/p/267733218)

-   [MonitorControl（控制显示器音量）](https://github.com/MonitorControl/MonitorControl)

-   [One Switch 1.22 中文破解版 (系统功能快速开关工具)](https://macwk.com/soft/one-switch)

-   终端:

    -   [iTerm2（已原生支持M1）](https://iterm2.com/downloads/stable/iTerm2-3_4_10.zip)

    >   -   [Mac OS 终端利器 iTerm2](https://www.cnblogs.com/xishuai/p/mac-iterm2.html)
    >   -   [iTerm2 3.5.0beta2 中文版 (强大的终端神器)](https://macwk.com/soft/iterm2)

    ```bash
    $ vim ~/.zprofile
     
    ## iTerm
    ### color 如果启用了ohmyzsh，貌似无需设置此处color
    #Set CLICOLOR if you want Ansi Colors in iTerm2
    #export CLICOLOR=1
    #setsup thecolor scheme for list export
    #export LSCOLORS=gxfxcxdxbxegedabagacad
    #sets up theprompt color (currently a green similar to linux terminal)
    #export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$     '
    #Set colors to match iTerm2 Terminal Colors
    #export TERM=xterm-256color
    ### proxy 配置代理别名
    alias setproxy="export ALL_PROXY=socks5://127.0.0.1:1080"
    alias unsetproxy="unset ALL_PROXY"
    ## mysql
    export PATH=$PATH:/usr/local/mysql/bin
     
    $ source ~/.zprofile
     
    $ setproxy
    $ curl cip.cc
    $ unsetproxy
    ```

    ```bash
    # vim可配色
    echo 'syntax on
    set number
    set ruler' >> ~/.vimrc
    ```

    >   -   iTerm2 需要更换为powerline字体（可选Snazzy主题），并选中 use built-in powerline glyphs，和 Use ligatures等，[可参考此文章](https://blog.csdn.net/hiumanChung/article/details/111225497)
    >       [![iTerm2设置备份](https://ghost.oss.sherlocky.com/halo/iTerm2%E8%AE%BE%E7%BD%AE%E5%A4%87%E4%BB%BD.png-halo)](https://ghost.oss.sherlocky.com/halo/iTerm2设置备份.png-halo)
    >   -   [10 个 Terminal 主题，让你的 macOS 终端更好看](https://sspai.com/post/53008)
    >   -   [iTerm Color Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes)

    -   Oh My Zsh

        ```bash
        #安装
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        brew install zsh-syntax-highlighting
        brew install zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
        ```

        修改

        ```
        ~/.zshrc
        ```

        ```makefile
        plugin (git
        macos
        zsh-syntax-highlighting
        zsh-autosuggestions)
        ZSH_THEME=agnoster
        DEFAULT_USER="sherlock"
        ```

        ```bash
        echo 'ZSH_DISABLE_COMPFIX="true"' >> ~/.zshrc
         
        whoami
         
        # python和pip安装方法参考后文python部分
        pip install powerline-status --user
         
        source ~/.zshrc
         
        whoami
        ```

    -   安装 Anaconda 后终端出现的

        ```
        (base)
        ```

        字样去除方法

        ```bash
        echo 'changeps1: False' >> vi ~/.condarc
        ```

    -   SSH

        -   [FinalShell](http://www.hostbuf.com/downloads/finalshell_install.pkg)
        -   [Termius 7.21.1 破解版 (最好用的SSH连接客户端) （已原生支持M1）](https://macwk.com/soft/termius)
        -   [Transmit 5.8.2 中文破解版 (最好用的FTP客户端)](https://macwk.com/soft/transmit)

-   [Royal TSX 5.0.4.1000 破解版 (最强远程管理软件)（已原生支持M1）](https://macwk.com/soft/royal-tsx)

-   [Hyper 3.1.4 (命令行终端美化模拟器)（已原生支持M1）](https://macwk.com/soft/hyper)

-   [SoundSource 5.3.7 破解版 (功能强大的mac音量控制器)（已原生支持M1）](https://macwk.com/soft/soundsource)

-   [TopNotch隐藏刘海](https://topnotch.app/)

-   [macOS 小助手 1.3.3 中文版 (mac常用命令集合)（已原生支持M1）](https://macwk.com/soft/macos-assistant-macwk)

-   [腾讯柠檬清理（已原生支持M1）](https://lemon.qq.com/)

-   [CleanMyMac X 4.8.9 中文破解版 (Mac优化清理工具)](https://macwk.com/soft/cleanmymac-x)

    >   目前 CleanMyMac X 已知的问题有：电脑变卡甚至失去响应，权限丢失，pd 使用卡，one drive 无限上传，office 无法激活，todesk 运行无法连接等。

-   [App Cleaner & Uninstaller Pro 7.4.4 中文破解版 (应用深度清理卸载工具)](https://macwk.com/soft/app-cleaner-and-uninstaller-pro)

    >   [mac系统最好的软件卸载工具 - 专治应用残留卸载不干净的问题](https://macwk.com/article/the-best-mac-uninstaller)

-   [Tuxera NTFS 2020.2 中文破解版 (NTFS磁盘读写工具)（原生支持M1）](https://macwk.com/soft/tuxera-ntfs)

    >   代理商已要求下架。。

-   虚拟机：

    -   Parallels Desktop for ARM 17.0.1 （原生支持M1）

        >   [Parallels Desktop 17安装Windows11+PD最佳设置+永久使用教程](http://www.jbzy.cn/446.html)
        >   [【绝版资源】Parallels Desktop 17一键启动Win11](http://www.jbzy.cn/476.html)
        >   开源启动器 [PD Runner](https://github.com/lihaoyun6/PD-Runner)
        >   [PD Runner 0.2.14 中文版 (PD 启动器/PD 无限试用)](https://macwk.com/soft/pd-runner)
        >   还可参见自己百度云盘
        >   官网：https://my.parallels.com/desktop/beta
        >   [M1跑ARM版Windows，爽不爽？](https://mp.weixin.qq.com/s/OfM6xy2KCsDlZYCNSoT-pg)
        >   当前已使用18版本，购买了标准版企业授权+Win11-21H2_1215镜像。

    -   [VMware Fusion Pro 12.2.0 中文破解版（原生支持M1）](https://macwk.com/soft/vmware-fusion)

        >   -   Pro 12.0/12.1/12.2 最低需 macOS 10.15 系统，支持 macOS 11 Big Sur，但是不支持 m1！
        >   -   Pro 12.2.0 支持 m1，最低需 macOS 11 系统，支持安装 linux arm 系统，但是不支持 安装 windows 系统。
        >   -   Intel 处理器没啥限制，可以尽情享用！

    -   [UTM虚拟机](https://mac.getutm.app/)

    -   硬盘检测[smartctl](https://www.smartmontools.org/wiki/Download#InstalltheOSXDarwinpackage)

        >   `brew install smartmontools`
        >   `smartctl -a /dev/disk0`
        >   里面的Percentage Used 就是损耗值，Data Units Written 就是写入量。

## 1.2 生活常用

-   [搜狗输入法（已原生支持M1）](https://pinyin.sogou.com/mac/)

-   [MacZip (eZip) 2.2 中文版 (很好用的压缩解压软件) （已原生支持M1）](https://macwk.com/soft/ezip)

-   [MacZip 2.2 中文版 官方地址](https://ezip.awehunt.com/download?s=web)

-   [Bandizip](https://www.icheese.org/mac-app/system/bandizip-for-mac/)

-   [企业微信](https://work.weixin.qq.com/wework_admin/commdownload?platform=mac&from=wwindex)

-   [微信（已原生支持M1）](https://dldir1.qq.com/weixin/mac/WeChatMac.dmg)

-   [QQ](https://dldir1.qq.com/qqfile/QQforMac/QQ_6.7.5.dmg)

-   [Microsoft Edge 中文版（已原生支持M1）](https://go.microsoft.com/fwlink/?linkid=2093504&platform=Mac&Consent=0&channel=Stable)

-   [Chrome（已原生支持M1）](https://www.google.com/chrome/)

-   [星愿浏览器](https://www.twinkstar.com/)

-   音乐播放

    -   [Audirvana3.5.50 中文破解版 (无损音乐播放器)](https://macwk.com/soft/audirvana)
    -   [YesPlayMusic 网易云音乐（已原生支持M1）](https://macwk.com/soft/yesplaymusic)
    -   [酷狗](https://download.kugou.com/download/kugou_mac)
    -   [foobar2000](https://www.foobar2000.org/mac)

-   视频播放：

    -   [IINA](https://iina.io/)
    -   [Movist Pro 2.6.7 中文破解版（2.6.0+已原生支持M1）](https://macwk.com/soft/movist)
    -   [VLC（已原生支持M1）](https://free.nchc.org.tw/vlc/vlc/3.0.16/macosx/vlc-3.0.16-arm64.dmg)
    -   [MX Player](https://mxplayerdownload.co/download-mx-player-mac-imacmacbook-airpro)

-   [Free Download Manager 6.15.3 中文版](https://dn3.freedownloadmanager.org/6/latest/fdm.dmg)

-   [Progressive Downloader 4.10.20 中文破解版 (mac多线程下载器)（已原生支持M1）](https://macwk.com/soft/progressive-downloader)

-   [Synology Drive Client](https://www.synology.cn/zh-cn/support/download/DS918+?version=6.2#utilities)

    >   [3.0.2-12682 macOS版本直接下载地址](https://cndl.synology.cn/download/Utility/SynologyDriveClient/3.0.2-12682/Mac/Installer/synology-drive-client-12682.dmg?model=DS918%2B&bays=4&dsm_version=6.2.4&build_number=25556)

-   [小米云服务](https://i.mi.com/static2?filename=MicloudWebStatic/res/home/mi-lab.htm&locale=zh_CN)

-   [百度云](https://issuecdn.baidupcs.com/issue/netdisk/MACguanjia/BaiduNetdisk_mac_4.1.0.dmg)

-   [阿里云盘](https://www.aliyundrive.com/download)

-   [Downie 4.3.8 (4301) 中文破解版 (最好的视频下载器)](https://macwk.com/soft/downie)

    >   千万要取消自动更新!!!

-   视频转码

    -   [Permute 3.7.4 (2521) 中文破解版 (视频音频格式转换)](https://macwk.com/soft/permute)

    >   千万要取消自动更新!!!

    -   [MKVToolNix官方网站](https://mkvtoolnix.download/downloads.html#macosx)

        >   官方不保证macOS平台下支持性：可从以下两个地址下载，或者使用brew安装
        >   https://mkvtoolnix.download/macos/
        >   https://www.fosshub.com/MKVToolNix.html
        >   https://formulae.brew.sh/cask/mkvtoolnix#default

## 1.3 办公

-   [Office for Mac](https://macwk.com/soft/office)

    >   查找名称为`com.microsoft.office.licensingV2.helper`的启动服务，将其设置为启动。

-   [WPS](https://www.wps.cn/product/wpsmac)

-   [PDF Reader Pro 2.8.2.3 中文破解版](https://macwk.com/soft/pdf-reader)

-   [Adobe Acrobat Pro DC 2021.007.20091 中文破解版](https://macwk.com/soft/adobe-acrobat-pro-dc)

-   [Sublime Text 4.0 Build 4118 Dev 中文破解版 (已原生支持M1](https://macwk.com/soft/sublime-text)

-   Visual Studio Code (已原生支持M1)

    >   https://code.visualstudio.com/docs/setup/mac
    >   https://code.visualstudio.com/docs/?dv=osx

-   [Atom （M1 需要转译）](https://github.com/atom/atom/releases/download/v1.58.0/atom-mac.zip)

-   [XMind 2021 11.1.0 (202109232210) 中文破解版（已原生支持M1）](https://macwk.com/soft/xmind)

-   笔记: [Typora（已原生支持M1）](https://typora.io/) + PicGO

    >   官方1.0开始已开始收费
    >   https://typora.io/releases/all
    >   [PicGo.app](https://github.com/Molunerfinn/picgo/releases)

-   [腾讯会议（已原生支持M1）](https://meeting.tencent.com/download-mac.html?from=1000&fromSource=1&macType=apple)

-   [Foxmail](https://www.foxmail.com/mac/download)

-   [向日葵](https://sunlogin.oray.com/download/)

-   [ToDesk](https://dl.todesk.com/macos/ToDesk_macOS_2.0.3.pkg)

-   [Best Trace（美国区商店）](https://apps.apple.com/us/app/best-trace/id1037779758?l=zh&ls=1&mt=12)

-   [Adobe M1 系列 2021 中文破解版 (适用于M1芯片的Adobe全家桶)](https://macwk.com/soft/adobe-m1)

-   [Snipaste 2.7 Beta 中文版 (支持贴图的截图工具)](https://macwk.com/soft/snipaste)

-   [iShot 1.8.5 中文版 (支持长截图的截图工具) （已原生支持M1）](https://macwk.com/soft/ishot)

-   [【开源】Kap 不错的屏幕录制工具（已原生支持M1）](https://github.com/wulkano/kap)

-   软媒云日历（凑合用）

-   [Things 3.15.2 中文破解版 (GTD时间日程管理工具) （已原生支持M1）](https://macwk.com/soft/things)

-   [小历 1.17.1 中文破解版 (漂亮的状态栏日历)（已原生支持M1）](https://macwk.com/soft/tinycal)

-   [Fantastical 2.5.16 中文破解版 (爱不释手的日历应用)](https://macwk.com/soft/fantastical)

## 1.4 效率提升

-   [Alfred 中文破解版 (本地搜索及应用快速启动)（已原生支持M1）](https://macwk.com/soft/alfred-4)

    >   安装完成进入欢迎入门界面的时候点击 跳过设置，`千万不要点开始设置`，否则会激活失败。
    >   历史剪贴板不可用的请确保在 Alfred 的偏好设置 -> Features -> Clipboard History -> 剪贴板历史选项下勾选了 保留纯文本、保留图标、保留文件列表的选项。

-   [uTools（已原生支持M1）](https://u.tools/)

-   [Paste 3.0.11 中文破解版 (剪切板增强工具) （已原生支持M1）](https://macwk.com/soft/paste)

-   [FastClip（AppStore良心1元）（已原生支持M1）](https://cn.fastclip.app/)

-   [Path Finder 10.2 中文破解版 (强大的Finder替代工具)](https://macwk.com/soft/path-finder)

-   QSpace 商店收费45¥

-   [EasyFinder2 文件/文件夹/软件快速访问和启动工具](https://www.easyfinderapp.com/)

-   [Beyond Compare 4.4.0 (25886) 中文破解版 (文件对比比较神器)](https://macwk.com/soft/beyond-compare)

-   [Better365团队出品BetterAndBetter、自动切换输入法、超级右键、iShot、FastZip等多款macOS软件](https://www.better365.cn/apps.html)

-   [HoudahSpot 6.1.8 (699) 中文破解版 (支持内容高亮的搜索工具)](https://macwk.com/soft/houdahspot)

-   [定时关闭App](https://marco.org/apps#quitter)

-   [Mac 下的定时任务工具：Launchctl](http://wu.run/2019/03/27/mac-launchctl-guidance/)

    >   https://www.launchd.info/

## 1.5 开发

-   Java

    -   zulu-jdk8

        >   https://www.winsonlo.com/it/howto/zulu-jdk8-on-m1/
        >   https://www.azul.com/downloads/?version=java-8-lts&os=macos&architecture=arm-64-bit&package=jdk
        >   下载地址：https://cdn.azul.com/zulu/bin/zulu8.58.0.13-ca-jdk8.0.312-macosx_x64.dmg

    -   zulu-jdk11

        >   https://www.azul.com/downloads/?version=java-11-lts&os=macos&architecture=arm-64-bit&package=jdk

    -   MacBook Pro M1 Java 开发环境搭建

        >   https://juejin.cn/post/6975767893778628616

    -   Java-环境搭建（Mac版）

        >   https://juejin.cn/post/6844903895504797710

    -   Oracle JDK 17 on M1

        >   https://www.oracle.com/java/technologies/downloads/#jdk17-mac
        >   下载地址：https://download.oracle.com/java/17/latest/jdk-17_macos-aarch64_bin.dmg
        >   zulu-jdk17 下载地址：https://cdn.azul.com/zulu/bin/zulu17.28.13-ca-jdk17.0.0-macosx_aarch64.dmg
        >   反编译：[JD-GUI](https://github.com/java-decompiler/jd-gui/releases/download/v1.6.6/jd-gui-osx-1.6.6.tar)

        >   [Java I tell you - 各种JAVA JDK的镜像分发](https://www.injdk.cn/)

-   Maven

    >   下载地址：https://maven.apache.org/download.cgi

```bash
export MAVEN_HOME=/opt/maven/apache-maven-3.8.4
export PATH=$PATH:$MAVEN_HOME/bin
 
source ~/.zprofile
mvn -version
 
#需要给 Maven 仓库设置访问权限
chmod -R 777 /Users/xxx/.m2/repository
```

-   maven-mvnd

    -   项目地址：[mvnd](https://github.com/apache/maven-mvnd/releases)

    -   安装方法

        ```bash
        brew install mvndaemon/homebrew-mvnd/mvnd
        mvnd -v
        mvnd clean verify
        ```

-   Gradle

    >   `brew install gradle`

-   [IDEA（已原生支持M1）](https://www.jetbrains.com/zh-cn/idea/download/download-thanks.html?platform=macM1)

    >   -   [IntelliJ IDEA For Mac 快捷键](https://www.jianshu.com/p/163a69cdafcc)
    >   -   [Mac IDEA常用快捷键](https://www.jianshu.com/p/78d6b83be9f6)
    >   -   [IntelliJ IDEA 的 Win 和 Mac 快捷键大全](https://mp.weixin.qq.com/s/H3jjrwBDBk4YCZDvpCSQcg)

-   IDEA 优化

    >   [JetBrains 开发工具使用最新的 JBR 提高性能](https://www.v2ex.com/t/805934)
    >   [JetBrains 开发工具使用最新的 JBR 提高性能](https://blog.huijiewei.com/note/jetbrains-jbr-17)
    >   [jbr17_0_1b164.8](https://github.com/JetBrains/JetBrainsRuntime/releases/tag/jbr17_0_1b164.8)
    >   vm配置文件在`~/Library/Application Support/JetBrains/IntelliJIdea2021.3/idea.vmoptions`

```bash
--illegal-access=warn
-Dsun.java2d.metal=true
--add-opens=java.desktop/java.awt.event=ALL-UNNAMED
--add-opens=java.desktop/sun.font=ALL-UNNAMED
--add-opens=java.desktop/java.awt=ALL-UNNAMED
--add-opens=java.desktop/sun.awt=ALL-UNNAMED
--add-opens=java.base/java.lang=ALL-UNNAMED
--add-opens=java.base/java.util=ALL-UNNAMED
--add-opens=java.desktop/javax.swing=ALL-UNNAMED
--add-opens=java.desktop/sun.swing=ALL-UNNAMED
--add-opens=java.desktop/javax.swing.plaf.basic=ALL-UNNAMED
--add-opens=java.desktop/java.awt.peer=ALL-UNNAMED
--add-opens=java.desktop/javax.swing.text.html=ALL-UNNAMED
--add-exports=java.desktop/sun.font=ALL-UNNAMED
--add-exports=java.desktop/com.apple.eawt=ALL-UNNAMED
--add-exports=java.desktop/com.apple.laf=ALL-UNNAMED
--add-exports=java.desktop/com.apple.eawt.event=ALL-UNNAMED
## fix IDEA 2021.3.2 with jbr 17 menu bar unavailable
--add-opens=java.desktop/sun.lwawt.macosx=ALL-UNNAMED
```

-   IDEA 自定义快捷键

    -   IDEA 快速打开文件所在目录

        >   参考：[mac版idea打开文件所在目录](https://cloud.tencent.com/developer/article/1640081)
        >   改进：Show in Finder（在访达中打开）

        ```ruby
        /usr/bin/open
        # -R 代表选中文件，而不是打开文件
        -R $FileDir$/$FileName$
        $ProjectFileDir$
        ```

        >   单独配置一个鼠标快捷键 ctrl+option+cmd+单击

-   IDEA PlantUML

    >   安装插件`PlantUML integration` + graphviz
    >   `brew install graphviz`

-   Git:

    >   https://git-scm.com/download/mac

    -   SourceTree

        >   https://www.sourcetreeapp.com/

-   数据库客户端: [Navicat](https://macwk.com/soft/navicat-premium)，[DataGrip（已原生支持M1）](https://www.jetbrains.com/datagrip/download/download-thanks.html?platform=macM1)

-   MongoDB: [Studio 3T（试用版）](https://studio3t.com/download/)

    >   [Mac Studio 3T解除时间限制](https://blog.csdn.net/liliang_1314/article/details/110915186)
    >   [mac App 破解之路六 studio 3t](https://www.cnblogs.com/dzqdzq/p/11261419.html)

-   [Redis Desktop Manager 2021.6.192 中文破解版（已原生支持M1）](https://macwk.com/soft/redis-desktop-manager)

-   [Another Redis Desktop Manager 1.4.9](https://github.com/qishibo/AnotherRedisDesktopManager/releases)

    >   也可以通过brew安装`brew install --cask another-redis-desktop-manager`

-   接口测试：

    -   https://www.postman.com/downloads/
    -   https://www.apipost.cn/download.html（已原生支持M1）

-   画图

    >   https://github.com/jgraph/drawio-desktop/
    >   https://github.com/jgraph/drawio-desktop/releases/download/v15.4.0/draw.io-arm64-15.4.0.dmg （原生适配M1）

-   Docker

    -   [Docker Desktop for Apple silicon](https://docs.docker.com/desktop/mac/apple-silicon/)

    -   [Install Docker Desktop on Mac](https://docs.docker.com/desktop/mac/install/)

    -   [Docker buildx](https://docs.docker.com/buildx/working-with-buildx/)

    -   [使用 buildx 在 M1 Mac 上构建 x86 Docker 镜像](https://printempw.github.io/build-x86-docker-images-on-an-m1-macs/)

        >   Docker 的 buildx 还是实验性功能，需要在 Docker Desktop 设置中开启，具体位于 Preferences > Experimental Features > Enable CLI experimental features。

    -   镜像加速

    ```bash
    "registry-mirrors": [
      "https://xxx.mirror.aliyuncs.com",
      "https://05cec16ef1800f790fabc01198b68720.mirror.swr.myhuaweicloud.com"
    ],
    ```

    -   禁用scan

        >   构建完镜像本地有时会报错 Use ‘docker scan’ to run Snyk tests against images to find vulnerabilities and learn how to fix them
        >   解决办法：在`~/.zshrc`添加`export DOCKER_SCAN_SUGGEST=false`

-   富强:

    -   V2rayU https://github.com/yanue/V2rayU/releases/download/3.2.0/V2rayU.dmg
    -   V2rayX https://github.com/Cenmrev/V2RayX/releases/download/v1.5.1/V2RayX.app.zip
    -   clashX
        https://github.com/yichengchen/clashX
    -   [Proxifier 3.6.6 破解版 (Mac系统全局代理客户端)（已原生支持M1）](https://www.macwk.com/soft/proxifier)

-   转码

    -   [FFmpeg静态编译版（不支持原生M1，作者不计划适配，并生成性能不受影响）](https://evermeet.cx/ffmpeg/)

        >   https://evermeet.cx/ffmpeg/ffmpeg-4.4.1.7z
        >   https://evermeet.cx/ffmpeg/ffprobe-4.4.1.7z
        >   https://evermeet.cx/ffmpeg/ffplay-4.4.1.7z

    -   [FFmpge编译安装](https://github.com/ssut/ffmpeg-on-apple-silicon)

        >   目前编译安装多次，均失败了，暂时先用静态版本吧

    -   [ImageMagick](https://imagemagick.org/script/download.php)

        ```bash
        brew install imagemagick
        brew install ghostscript
        #如果需要 svg支持
        brew install librsvg
        #svg需要使用命令
        rsvg-convert 1.svg -o 1.png
        ```

-   [WireShark 抓包（原生支持M1）](https://www.wireshark.org/#download)

-   [Fiddler（试用版）](https://www.telerik.com/download/fiddler/fiddler-everywhere-osx)

    >   网盘收藏了一个mac天空免费版

-   Android

    -   [Android Studio（已原生支持M1）](https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2020.3.1.25/android-studio-2020.3.1.25-mac_arm.zip)

        >   https://developer.android.google.cn/studio?hl=zh-cn#downloads
        >   https://zhuanlan.zhihu.com/p/384730100
        >   https://developer.android.com/studio/archive
        >   https://zhuanlan.zhihu.com/p/372158270

    -   [NDK 下载 （貌似也不需要了）](https://developer.android.google.cn/ndk/downloads?hl=zh-cn)

    -   ADB (貌似不需要单独安装了，studio就带有)

        >   `brew cask install android-platform-tools`
        >   安装完在：`~/Library/Android/sdk/platform-tools`

-   [Node - M1芯片Mac搭建前端开发环境](https://www.jianshu.com/p/ef16b3bec42b)

```bash
brew install nvm
#安装完需要按照提示手动配置下.zshrc
nvm i v15
## 切换到x64下安装v12版本
arch -x86_64 zsh
nvm install v12
 
npm install exceljs
 
npm install -g agentkeepalive
npm install -g npm@8.3.0
npm -v
```

-   Python

    -   安装方法

        ```bash
        brew install python
        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python3 get-pip.py
        ```

    -   国内镜像源

        ```bash
        mkdir ~/.pip
        echo '[global]
        timeout = 6000
        index-url = https://pypi.tuna.tsinghua.edu.cn/simple
        trusted-host = pypi.tuna.tsinghua.edu.cn' > ~/.pip/pip.conf
        # 或者
        echo '[global]
        timeout = 6000
        index-url = https://mirrors.aliyun.com/pypi/simple/
        trusted-host = mirrors.aliyun.com' > ~/.pip/pip.conf
        ```

    -   [Anaconda](https://www.anaconda.com/products/individual)

    -   [Anaconda 镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/)

-   Go

    -   [官网（已原生支持M1）](https://go.dev/dl/)

    -   国内镜像加速

        ```bash
        # 启用 Go Modules 功能
        go env -w GO111MODULE=on
        # 七牛 CDN
        go env -w  GOPROXY=https://goproxy.cn,direct
        # 测试是否生效
        go env | grep GOPROXY
        ```

# 2.macOS 软件网站

-   https://macwk.com/soft/all/p1?platform=m1

    >   [MacWk Updater 0.4.2 中文版 (MacWk应用更新管理器)](https://macwk.com/soft/macwk-updater)

-   [马可喵（有的收费）](https://www.macat.vip/)

-   https://www.icheese.org/mac-app/

-   https://www.tntmac.com/

-   https://imactnt.com/ (所谓的TNT中国)

-   https://nmac.to/

-   https://macdrop.net/

-   https://mac-torrent-download.net/

-   [马可菠萝 - 分享你喜欢的MAC应用](https://www.macbl.com/)

-   [Mac和iOS最佳免费工具App集合 - Oka Apps](https://zh.okaapps.com/)

-   [绝版资源【**收费**】](http://www.jbzy.cn/)

-   [mac天空【**收费**】](https://www.mac69.com/)

-   [已经为M1版MacBook优化的macOS应用程序之完整指南](https://isapplesiliconready.com/zh)

# 3.常见问题处理

## 3.1 ARM M1 芯片的 Macs 常见问题的解决方法

https://macwk.com/article/arm-macs-issue

## 3.2 macOS “不能安装该软件，因为当前无法从软件更新服务器获得” 解决方法

https://macwk.com/article/macos-command-line-tools-cannot-be-installed

## 3.3 xxx.app 已损坏，无法打开，你应该将它移到废纸篓/打不开 xxx，因为它来自身份不明的开发者解决方法

https://macwk.com/article/macos-file-damage

## 3.4 SIP系统完整性保护怎么禁用？SIP系统完整性关闭方法

https://macwk.com/article/sipmac

## 3.5 什么是 macOS 应用签名？应用公证又是什么意思？

https://macwk.com/article/macos-app-signatures