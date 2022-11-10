#!/usr/bin/env zsh


# 打印脚本描述头
printScriptDesHead() {
    local SCRIPT_RUNNING_TIME=$(date "+%Y-%m-%d %H:%M:%S")
    local OS_VER=$(/usr/bin/sw_vers -productVersion)
echo '
        \033[1;32m开始执行 "自动配置 Mac 开发环境脚本"
                    version: v1.0
                    author : eisenhao
                    blog   : https://eisenhao.cn
        run time: ['$SCRIPT_RUNNING_TIME'], your macOS: ['$OS_VER']
\033[0m'
}


############  Script Running Start ############
# 打印脚本描述头
printScriptDesHead