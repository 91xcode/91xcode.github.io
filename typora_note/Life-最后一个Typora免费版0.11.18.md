@[TOC](这里写自定义目录标题)

# **最后一个Typora免费版0.11.18**

>   Typora是一个所见即所得的Markdown跨平台写作工具，目前已经发布正式版，并且更改为付费模式，0.11.18_beta是最后一个免费的测试版，有需要的可以选择下载。

## Windows用户

下载地址： ~~https://github.com/iuxt/src/releases/download/2.0/typora-0-11-18.exe~~

0.11.18现在被远程施法了，会提示过期无法使用,可以使用0.9.96版

下载地址：https://github.com/iuxt/src/releases/download/2.0/typora-setup-x64_0.9.96.exe

## Mac用户

下载地址： https://github.com/iuxt/src/releases/download/2.0/typora-0-11-18.dmg

## Ubuntu用户

下载地址：https://github.com/iuxt/src/releases/download/2.0/Typora_Linux_0.11.18_amd64.deb

使用apt安装：

```
sudo apt install ./Typora_Linux_0.11.18_amd64.deb 
```

## 其他Linux用户（非debian系）

下载地址：https://github.com/iuxt/src/releases/download/2.0/typora-0-11-18.tar.gz

### 解压

```
tar xf typora-0-11-18.tar.gz -C /opt/ 
```

### 创建桌面文件和图标

```
> vim ~/.local/share/applications/typora.desktop [Desktop Entry] Name=Typora Comment=A minimal Markdown reading & writing app. Change Log: (https://typora.io/windows/dev_release.html) GenericName=Markdown Editor Exec=/opt/typora/Typora Icon=/opt/typora/resources/assets/icon/icon_256x256@2x.png Type=Application Categories=Office;WordProcessor;Development; MimeType=text/markdown;text/x-markdown;
```