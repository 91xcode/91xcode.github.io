#!/bin/sh
fname=`basename $3`
osascript <<EOF
display notification "$fname 已经下载完成！" with title "【下载完成】"
say "有个文件下载完成，请查收！"
EOF