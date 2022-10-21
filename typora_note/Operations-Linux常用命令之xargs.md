# **Linux常用命令之xargs**

多行输入单行输出：

```
# cat test.txt | xargs

a b c d e f g h i j k l m n o p q r s t u v w x y z
-n 选项多行输出：

# cat test.txt | xargs -n3

a b c
d e f
g h i
j k l
m n o
p q r
s t u
v w x
y z
-d 选项可以自定义一个定界符：

# echo "nameXnameXnameXname" | xargs -dX

name name name name

结合 -n 选项使用：

# echo "nameXnameXnameXname" | xargs -dX -n2

name name
name name
```

读取 stdin，将格式化后的参数传递给命令 假设一个命令为 sk.sh 和一个保存参数的文件 arg.txt：

```
#!/bin/bash       #   sk.sh命令内容，打印出所有参数。
echo $*
```

arg.txt文件内容：

```
# cat arg.txt

aaa
bbb
ccc
```

xargs 的一个选项 -I，使用 -I 指定一个替换字符串 {}，这个字符串在 xargs 扩展时会被替换掉，当 -I 与 xargs 结合使用，每一个参数命令都会被执行一次：

```
# cat arg.txt | xargs -I {} ./sk.sh -p {} -l

-p aaa -l
-p bbb -l
-p ccc -l
```

复制所有图片文件到 /data/images 目录下： `ls *.jpg | xargs -n1 -I {} cp {} /data/images` 

xargs 结合 find 使用 用 rm 删除太多的文件时候，可能得到一个错误信息：/bin/rm Argument list too long. 用 xargs 去避免这个问题：

```
find . -type f -name "*.log" -print0 | xargs -0 rm -f

xargs -0 将 \0 作为定界符。
```

统计一个源代码目录中所有 php 文件的行数： 

`find . -type f -name "*.php" -print0 | xargs -0 wc -l` 

查找所有的 jpg 文件，并且压缩它们： 

`find . -type f -name "*.jpg" -print | xargs tar -czvf images.tar.gz`

查找并替换 

`find -name '要查找的文件名' | xargs perl -pi -e 's|被替换的字符串|替换后的字符串|g'`