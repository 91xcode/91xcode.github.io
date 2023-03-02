# ripgrep, grep 的替代工具





*grep* 是 macos、linux 系统上重要的工具，也是命令行终端中使用频率最高的工具之一。 它帮助用户搜索文本，最常用的很可能是 `ps -ef | grep xxx`，搜索进程。文本搜索是很多开发者的常见需求，不少好事之徒觉得 grep 不够快、不够顺手、不够现代化，因此就有了新的尝试。功能类似的工具有许多，早前有 *ack*,现在有 *ripgrep* ，这两个工具虽然很快，但用户还没有很多。有悟今天介绍 *ripgrep* ，希望大家也可以尝试一下。

>    [ripgrep ](https://github.com/BurntSushi/ripgrep)，使用 *rust* 编写，其源代码在 *github.com* 上公开。更新活跃、star 高，明星项目。
>
>   下文使用 *rg* 简称。

有悟并没有很长的命令行终端工作年限，对历史存在时间比较长的 grep ，还是不太能接受它的命令设计。它有 `gnu` 版本，unix 版本，并且因为支持功能的不同，有 grep 、fgrep、egrep 三个功能版本。egrep 是支持正则表达式、fgrep 主要用于搜索文件。 而有悟使用 *ripgrep* 大概两三年时间，虽然它有非常快的速度、同样有强大的命令参数，但主要还是用来关键字搜索代码文件，或者 `ps -ef | rg xxx`，最大的感受就是速度快、命令格式简单。

官方代码库有与其它同类工具的效率对比 [quick-examples-comparing-tools ](https://github.com/BurntSushi/ripgrep/blob/master/README.md#quick-examples-comparing-tools)。

[ack ](https://beyondgrep.com/)官方还放出了几个热门搜索工具的功能对比， [Feature comparison of ack, ag, git-grep, GNU grep and ripgrep ](https://beyondgrep.com/feature-comparison/)

## 使用[#](https://youwu.today/skill/tools/ripgrep-grep-alternative/#使用)

*rg* 的命令用法表达式：

```
USAGE:
    rg [OPTIONS] PATTERN [PATH ...]
    rg [OPTIONS] [-e PATTERN ...] [-f PATTERNFILE ...] [PATH ...]
    rg [OPTIONS] --files [PATH ...]
    rg [OPTIONS] --type-list
    command | rg [OPTIONS] PATTERN

ARGS:
    <PATTERN>    A regular expression used for searching.
    <PATH>...    A file or directory to search.
```

从命令语法上看，使用 `rg PATTERN [路径...]` 从指定路径上文件中搜索 `PATTERN`，如果需要同时搜索多个关键字，使用 `-e PATTERN` 来连接。当需要一次性搜索的`PATTERN` 太多时，可以使用 `-f PATTERNFILE`。可以使用 `--type-list` 来限定搜索的文件类型。同时，`command | rg [OPTIONS] PATTERN`，可以从终端标准输入中接收。

`OPTIONS` 非常多选择，具体使用 `rg -h` 查看。

如果看过有悟之前一篇介绍 *fd* 的文章，可能会觉得，*rg* 和 *fd* 的命令语法非常类似，比较符合有悟的使用习惯。有兴趣的可以看看，

[fd, 替代 find 命令的工具熟悉 *linux*、*macos* 的开发者，对 *find* 命令并不陌生。这个命令用来帮助搜索文件，可按文件名称、文件类型、文件大小等方式来搜索文件。这个工具历史比较悠久。而近几年，一个叫 *fd* 的工具呈现在用户眼前，它是具有类似于 *find* 命令的工具，在大部分情况下，*fd* 是可以当成 *find* 的替代工具来使用，它的一个主要特点就是快。](https://youwu.today/skill/tools/a-find-alternative-tool/)



## 较常用的场景[#](https://youwu.today/skill/tools/ripgrep-grep-alternative/#较常用的场景)

*rg* 比较年轻，融合了命令行文本搜索的最常见功能，下面仅列出有悟较常使用到的，大量功能特性等待你自己去挖掘。

>   在终端上，rg 的搜索结果是显示颜色的，下文中的示例是从字符终端工具下复制下来的文本，并不是真正的 rg 真正对应的颜色，特此说明。



### 大小写[#](https://youwu.today/skill/tools/ripgrep-grep-alternative/#大小写)

使用 *rg* 搜索时，大小写敏感。如下示例中使用的 `rghelp.md`，是使用 `rg -h > rghelp.md` 生成的。



```sh
~/Projects/aff/youwu git:(develop)
➜  rg -i RIPGREP
rghelp.md
1:ripgrep 12.1.1
4:ripgrep (rg) recursively searches your current directory for a regex pattern.
5:By default, ripgrep will respect your .gitignore and automatically skip hidden
10:Project home page: https://github.com/BurntSushi/ripgrep
97:        --pcre2-version                     Print the version of PCRE2 that ripgrep uses.
109:        --stats                             Print statistics about this ripgrep search.
```

上面示例是企图从当前目录搜索匹配 `RIPGREP`，并列出文件名与对应的行。大写的 `RIPGREP` 在 rg 的帮助说明中没有出现，所以使用 `rg RIPGREP` 并不能搜索出结果，加上 `-i` 就告诉 rg ，只要是 `RIPGREP`、`ripgrep`、甚至是 `RipgreP`，通通找出来。

### 多 PATTERN[#](https://youwu.today/skill/tools/ripgrep-grep-alternative/#多-pattern)

当需要同时匹配多个 pattern 时，使用 `-e` 来表示一个 pattern。



```sh
~/Projects/aff/youwu git:(develop)
➜  rg -e ripgrep -e OPTIONS rghelp.md
1:ripgrep 12.1.1
4:ripgrep (rg) recursively searches your current directory for a regex pattern.
5:By default, ripgrep will respect your .gitignore and automatically skip hidden
10:Project home page: https://github.com/BurntSushi/ripgrep
14:    rg [OPTIONS] PATTERN [PATH ...]
15:    rg [OPTIONS] [-e PATTERN ...] [-f PATTERNFILE ...] [PATH ...]
16:    rg [OPTIONS] --files [PATH ...]
17:    rg [OPTIONS] --type-list
18:    command | rg [OPTIONS] PATTERN
24:OPTIONS:
97:        --pcre2-version                     Print the version of PCRE2 that ripgrep uses.
109:        --stats                             Print statistics about this ripgrep search.
```

本例企图匹配 *rghelp.md* 中包含 `ripgrep` 或者 `OPTIONS` 的所有行。

### 正则表达式[#](https://youwu.today/skill/tools/ripgrep-grep-alternative/#正则表达式)

*rg* 默认的匹配就是正则表达式，如果你写的 pattern 是一个正则表达式，请使用`""`包裹起来。当 pattern 中包含正式则表达式字符但本身不是正式表达式的纯字符串时，使用 `-F` 告诉 *rg* 把 pattern 当成普通字符串来看待。



```sh
~/Projects/aff/youwu git:(develop)
➜  rg -F "rip.*ep" rghelp.md

~/Projects/aff/youwu git:(develop)
➜  rg  "rip.*ep" rghelp.md
1:ripgrep 12.1.1
4:ripgrep (rg) recursively searches your current directory for a regex pattern.
5:By default, ripgrep will respect your .gitignore and automatically skip hidden
10:Project home page: https://github.com/BurntSushi/ripgrep
97:        --pcre2-version                     Print the version of PCRE2 that ripgrep uses.
109:        --stats                             Print statistics about this ripgrep search.
```

### 反搜索[#](https://youwu.today/skill/tools/ripgrep-grep-alternative/#反搜索)

反搜索，表示显示不匹配的，使用选项 `-v`。



```sh
~/Projects/aff/youwu git:(develop)
➜  rg -v ripgrep rghelp.md
2:Andrew Gallant <jamslam@gmail.com>
3:
6:files/directories and binary files.
7:
8:Use -h for short descriptions and --help for more details.
9:
11:
...
下面省略
```

上例是列出文件 *rghelp.md* 中不包含 pattern `ripgrep` 的所有文本。

### 限定部分文件[#](https://youwu.today/skill/tools/ripgrep-grep-alternative/#限定部分文件)

-   按文件类型 有时你需要搜索某个类型的文件，如有悟经常需要在一个有 *html*、*json* 、*js*、*css* 多类型文件的目录下搜索。此时可以使用 `-t 类型名称` 来加以限定。



```sh
~/Projects/aff/youwu git:(develop)
➜  rg -t markdown ripgrep
rghelp.md
1:ripgrep 12.1.1
4:ripgrep (rg) recursively searches your current directory for a regex pattern.
5:By default, ripgrep will respect your .gitignore and automatically skip hidden
10:Project home page: https://github.com/BurntSushi/ripgrep
97:        --pcre2-version                     Print the version of PCRE2 that ripgrep uses.
109:        --stats                             Print statistics about this ripgrep search.
```

因为 *rghelp.md* 是 *markdow* 文件，加了 `-t markdown` 同样可以定位到 *rghelp.md*。

可以使用命令 `rg --type-list` 来查看 *rg* 中预定的文件类型。可以使用 `rg --type-add xxxx` 来加入新的类型定义，有悟比较少用。



```sh
~/Projects/aff/youwu git:(develop)
➜  rg -V
ripgrep 12.1.1

~/Projects/aff/youwu git:(develop)
➜  rg --type-list | wc -l
     159

~/Projects/aff/youwu git:(develop)
➜  rg --type-list | rg css
css: *.css, *.scss
sass: *.sass, *.scss
```

有悟当前安装的版本是 `12.1.1.`，一共有 `159` 个文件类型，如指定 `-t css` 时，会匹配 *css*、*scss* 文件。

-   按文件名 上面几个例子都是针对 *rghelp.md* ，则把需要搜索的文件名写在命令最后。
-   .gitignore/.ignore/.rgignore，并自动跳过隐藏文件

还有一个比较时兴的特性，就是 *ignore*，这一点与 *fd* 类似。像程序员使用 *git* 来做代码的版本管理，那么被放到 *.gitignore* 中的，一般是短期内不想去关心的文件，那么搜索工具默认忽略掉这些文件是不是对程序员用户很贴心呢！！！



```sh
~/Projects/aff/youwu git:(develop)
➜  rg --no-ignore ripgrep
rghelp.md
1:ripgrep 12.1.1
4:ripgrep (rg) recursively searches your current directory for a regex pattern.
5:By default, ripgrep will respect your .gitignore and automatically skip hidden
10:Project home page: https://github.com/BurntSushi/ripgrep
97:        --pcre2-version                     Print the version of PCRE2 that ripgrep uses.
109:        --stats                             Print statistics about this ripgrep search.

content/skill/tools/ripgrep.md
2:title: "ripgrep, grep 的替代工具"
4:slug: "ripgrep grep alternative "
...
下面省略
```

### 搜索结果[#](https://youwu.today/skill/tools/ripgrep-grep-alternative/#搜索结果)

*rg* 结果包含匹配的文件名，与匹配的文本行（带行号）。 有时仅仅是想搜索对应的匹配行内容，并复制到其它地方使用。如果不能去掉行号，那么这个匹配结果可以还需要二次编辑。 当然，这一点 *rg* 也考虑到了，选项 `-N` 表示不带行号，`-I` 表示不带文件名，两者可同时使用。



```sh
~/Projects/aff/youwu git:(develop)
➜  rg -N ripgrep
rghelp.md
ripgrep 12.1.1
ripgrep (rg) recursively searches your current directory for a regex pattern.
By default, ripgrep will respect your .gitignore and automatically skip hidden
Project home page: https://github.com/BurntSushi/ripgrep
        --pcre2-version                     Print the version of PCRE2 that ripgrep uses.
        --stats                             Print statistics about this ripgrep search.

~/Projects/aff/youwu git:(develop)
➜  rg -I ripgrep
1:ripgrep 12.1.1
4:ripgrep (rg) recursively searches your current directory for a regex pattern.
5:By default, ripgrep will respect your .gitignore and automatically skip hidden
10:Project home page: https://github.com/BurntSushi/ripgrep
97:        --pcre2-version                     Print the version of PCRE2 that ripgrep uses.
109:        --stats                             Print statistics about this ripgrep search.
```

### 搜索并替换[#](https://youwu.today/skill/tools/ripgrep-grep-alternative/#搜索并替换)

熟悉 `sed` 的人，对于使用 `rg` 来替换`sed` 日常搜索方面是比较满意的，不用再写很难一次成功的 `s/xxx/xxx/pg` 表达式，也不用被 macos、linux 上的 sed 版本问题困扰。

但 `rg` 还是不能替代 `sed`，因为 `rg` 并没有 *replace* 功能，在 gnu sed 可以使用 `-i` 选项，将先匹配的文本替换掉。而在`rg`中没有对等的操作。目前存在一种变通的方法。

比如像 `sed -i 's/xxx/yyy/g' 目标文本文件` 这个命令可以直接修改目标文件，使用 *rg* 要这么做。



```sh
➜ rg --passthru "xxx" --replace "yyy" file.txt --no-line-number > file.txt.tmp && mv file.txt.tmp file.txt
```

-   `--no-line-number`

    让 rg 的输出不带开头的行号，也简写为 `-N`

-   `--passthru`

    让不匹配 “xxx” 的其它行与输出

-   `--replace`

    将匹配的字符串 “xxx” 替换为 “yyy”，也简写为 `-r`

*rg* 没有就地修改的功能，但可以将正确结果先保存在临时文件，然后再将原文件替换掉。 上面的命令参数简写为 `rg --passthru "xxx" -r "yyy" file.txt -N > file.txt.tmp && mv file.txt.tmp file.txt`

## 安装[#](https://youwu.today/skill/tools/ripgrep-grep-alternative/#安装)

能看到这里的读者，想必对 *rg* 有点兴趣，那么可以考虑使用 *rg* 替代日常的 *grep* ，试试看。

-   macos 用户，可以使用 *brew* 安装, `brew install rg` 或者 `brew install ripgrep`
-   windows 用户，可以使用 *scoop* 安装，`scoop install ripgrep`
-   linux 用户，可以使用 *apt* 安装，`sudo apt install ripgrep`。
-   还可以到 [发布页 ](https://github.com/BurntSushi/ripgrep/releases/)下载二进制版本
-   *rust* 用户的，还可以自己克隆 github 上的源代码构造。 [building ](https://github.com/BurntSushi/ripgrep#building)。





常规使用：

1.查询字符串str 在/data/xx/ 目录下的所有文件中 如果查询到展示 打印匹配行前后 6 行

 ```
 rg  "str" "/data/xx/" -C6 
 ```

2.使用正则

```
rg -e "*sql" -C2
```

3.在两个文件类型中查找 在 `md` 文件或者 `html` 文件中查找 “mysql” 关键字

```
rg -g "*.{md,html}" "mysql"
```

4.使用 `-l` 来打印文件名

```
rg -l -w "word" .
```

5.相反的是如果要打印没有匹配内容的文件名

```
rg --files-without-match -w "word" .
```

6.使用 `-s` 选项来启用大小写敏感

```
rg -s "word" .
```

7.使用选项 `-v` 来显示不包含关键字的行

```
rg -v "word" .
```

8.可以使用 `-t type` 来指定文件类型：

```
rg -t markdown "mysql" .
```

9.支持的文件类型可以通过

```
rg --type-list
```

10.使用 `-c` 来显示匹配的次数：

```
rg -c "word" .
```

11.默认 rg 会忽略 `.gitignore` 和隐藏文件，可以使用 `-uu` 来查询所有内容：

```
rg -uu "word" .
```

搜索单词

```
rg -w "myword" .
```

比如搜索 abc，可能有些单词包含 dabce ，那么也会被搜索出来，而加上 `-w` 就不会搜索出来了




搜索文件
```
alias rgf='rg --files | rg'
```

搜索以 md 为后缀的文件
```
rg --files . | rg -e ".md$" # 正则匹配
```



https://www.liuvv.com/p/868944ef.html
