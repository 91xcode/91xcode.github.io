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
brew install --cask postman
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
brew install --cask navicat-premium
brew install --cask typora
brew install zsh zsh-completions
brew install ripgrep
brew install colima
brew install archey
brew install htop
brew install redis
# brew install nginx
# brew install php@7.2


brew cleanup

# 破解版的其他软件 可以登录 https://xmac.app/
# PDF_Office_Max_8.0
# Microsoft Office
# Little_Snitch_5.7.3.dmg 

