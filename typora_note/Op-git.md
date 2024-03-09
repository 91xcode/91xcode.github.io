@[TOC](这里写自定义目录标题)

# git

## 需求

>   git日常使用备注



![img](https://testingcf.jsdelivr.net/gh/91xcode/typora_img/img/typora/202312200000552.png)



参考：

https://yanhaijing.com/git/2014/11/01/my-git-note/

https://yanhaijing.com/git/2020/09/17/git-switch-and-restore/

https://yanhaijing.com/git/2017/02/09/deep-git-5/



## 步骤

### Git生成ssh-key

```bash
ssh-key

ssh-keygen -t rsa -C "$your_email"          # 获取 sshkey
cat ~/.ssh/id_rsa.pub                      # 查看 sshkey
```



### 基本

```
# 电脑初始化 git, 用 jPC/git_config
git clone https://github.com/coder352/jvim.git vim                 # 重命名
git clone --branch v1.9 https://github.com/ethicalhack3r/DVWA.git  # 下载指定 Tag
git clone --depth=1 https://github.com/coder352/jvim.git vim       # 只下载最近一次修改后的
git checkout *                                                     # 不小心改了别人的, 这个命令可以恢复
git push origin master
git add .
git add --all
git commmit -m "update"

git tag  # 查看都有哪些标签
git checkout <tag>  # 根据上面查到的标签来切换

git ls-remote  # 查看远端 repository
git remote -v  # 查看远端 repository

##################################################################
## 本地配置
git config --global user.name "Ruipeng Jia"
git config --global user.email 352111644@qq.com
# 添加代理
git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'
# 修改/添加 远程项目地址
git remote remove oritin
git remote add origin git@github.com:coder352/jVim.git
git remote add origin https://github.com/coder352/jVim.git
```



### 协作与分支推送

```
1.正常情况下，我们在github上看到一个clone地址，git clone xxxxxxx.git后，默认clone进入的是master分支，如果想切换到某一个子分支，可以使用 ---基于远端dev分支，新建本地test分支[同时设置跟踪]

git branch -a

git checkout -b test origin/dev

2.在本地创建和远程分支对应的分支，使用git checkout -b branch-name origin/branch-name，本地和远程分支的名称最好一致；

3.建立本地分支和远程分支的关联，使用git branch --set-upstream branch-name origin/branch-name；或者  git branch --set-upstream-to=origin/branch-name


git提示--set-upstream过时了。

4.git 怎么拉去指定分支的代码

git clone -b 分支名 仓库地址

5.比较2个分支指定某个文件的区别

git diff master dev_v3 -p  app/Services/Service.php

6.文件撤销修改恢复到远端master

git checkout origin/master -- filename.txt
```



### 使用git拉代码时可以使用 -b 指定分支

```
1.指定拉 master 分支代码

git clone -b master http://gitslab.yiqing.com/declare/about.git

2.指定拉 develop 分支代码

git clone -b develop http://gitslab.yiqing.com/declare/about.git

3.git clone xxx.git  下载文件到指定目录 并且重命名为xx
例如 
git clone https://github.com/plasticboy/vim-markdown.git ~/Downloads/xx

4.git clone --branch v1.9 https://github.com/ethicalhack3r/DVWA.git  # 下载指定 Tag
5.git clone --depth=1 https://github.com/coder352/jvim.git vim       # 只下载最近一次修改后的

git branch -a 这条命令并没有每一次都从远程更新仓库信息，我们可以手动更新一下

git fetch origin 
git branch -a

当我们删除远程分支后执行git branch -a本地却依然能看到远程分支

这个时候我们只需要执行git remote prune origin清理一下就可以了

然后再次执行git branch -a就看不到啦
```

### git log查询日志

```
使用命令git log查询日志，包含了多种快捷查询方式

    最简单查询

    $ git log

    单行输出

    $ git log --oneline

    指定关键字查询

    $ git log --grep 关键字

    指定作者查询

    $ git log --author 作者

```




### git-代码冲突常见解决方法

```
1) 在合并过程中不能做部分提交

git commit -im "commit message" xx

2)错误提示fatal: Paths with -a does not make sense.
git commit -am "注释（提交）说明""

3) 某个文件恢复到指定分支的版本

git checkout branch_name -- filename

4) 比较2个分支的指定文件

git diff branch_name1 branch_name2 具体文件路径
```

### git-变更文件名称大小写

```
git mv hello.txt Hello.txt
```



### git commit后回退方法(git 工作台回退)

```
修改了本地的代码，然后使用：

git add file
git commit -m '修改原因'
复制
执行commit后，还没执行push时，想要撤销这次的commit，该怎么办？

解决方案：
使用命令：

git reset --soft HEAD^
复制
这样就成功撤销了commit，如果想要连着add也撤销的话，--soft改为--hard（删除工作空间的改动代码）。

HEAD^ 表示上一个版本，即上一次的commit，也可以写成HEAD~1
如果进行两次的commit，想要都撤回，可以使用HEAD~2
复制
--soft
不删除工作空间的改动代码 ，撤销commit，不撤销git add file
复制
--hard
删除工作空间的改动代码，撤销commit且撤销add
复制
另外一点，如果commit注释写错了，先要改一下注释，有其他方法也能实现，如：

git commit --amend
这时候会进入vim编辑器，修改完成你要的注释后保存即可。
```



### Git 查看某个文件指定committed的全部内容

```

得到commitid
git log 

查看某个文件指定committed的全部内容
git show commitid:filenamepath

查看某个文件指定committed的修改内容
git show commitid filenamepath
```



### git add后回退方法

```
要在 commit（提交）之前撤销 git add，运行  git reset <file>  或  git reset 取消所有更改即可。
```





### 查看日志 需要配置 git lss




```
git config --global alias.ls "log --no-merges --color --graph --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Cblue %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit"

git config --global alias.lss "log --no-merges --color --stat --graph --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Cblue %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit"

查看指定成员 以及commit 含有的字符串
git lss --author liubing1 --grep '销售' -p

git lss --author liubing1

```

### git delete branch


```

1、查看项目的分支们(包括本地和远程)
     命令行 : $ git branch -a

2、删除本地分支

   git branch -d branch-name

3、删除远程分支
    git push origin --delete <branchName>
    或者
    git push origin :branch-name

4、查看删除后分支们
     命令行 : $ git branch -a

```


### git 文件太大 克隆失败的解决方法


```
当使用git clone 产生这个问题的时候，在第一次克隆的时候，把克隆深度设置为1，然后再fetch

git clone  https://example.com/example/example.git --depth  1
cd example
git fetch --unshallow
```
### git diff结果解读
```
diff –git a/f1 b/f1 //a版本的f1（变动前） 与 b版本的f1（变动后） 比较
index6f8a38c..449b072 100644 //a版本的在index的对象的哈希值 b版本在工作区的对象的哈希值 文件信息（644表示权限）

- a/f1 //变动前的文件
+++ b/f1 //变动后的文件
@@ -1,7 +1,7 @@ //变动前的文件从第一行开始的7行 与 变动后的文件第一行开始的7行存在不同
//以下是比较信息 一行前面有- + ！或者没有表示，分别表示删、增、改、没有修改。
```



### git diff比较介绍

```
git diff 用来比较文件之间的不同，其基本用法如下。

git diff：显示工作目录(working tree)与索引区(即暂存区快照，就是git add过后的)之间的文件变更，即显示未被add的文件变更。

git diff --cached 或 git diff --staged：显示索引区和最后一次commit(HEAD)之间的文件更改，即显示已add但还未commit的文件变更。也即用"git commit"（不带-a）将被提交的文件变更。

git diff HEAD：显示工作目录与最后一次commit之间的文件变更，即显示所有未commit（包括未add和add两类）的文件变更。也即用"git commit -a”将被提交的文件变更。

git diff <分支名1> <分支名2> ：比较两个分支上最后 commit 的内容的差别。比如，先git fetch下，然后比较远程的master与当前分支已经commit的内容差别：git diff origin/master origin/2201。此时是以origin/master分支为基础进行比较的，若把2201分支写在前面，则是以2201分支为基础进行比较的。 也可写作：git diff <分支名1>..<分支名2> 。

要查看具体有哪些文件发生了变化，可以加上--stat参数：

git diff origin/master origin/2201 --stat

  
 
根据--stat的结果可得到存在差异的文件列表，然后可用git diff 进一步查看该文件在两个分支中的差异：

git diff origin/master origin/2201 biz/src/main/java/com/sports/gerrard/biz/service/MarketingActivityService.java 

```







### git冲突标记

```
<<<<<<< HEAD 是指你本地的分支的
------------

如下：
<<<<<<< HEAD
b789
=======
b45678910
>>>>>>> 6853e5ff961e684d3a6c02d4d06183b5ff330dcc

head 到 =======里面的b789是您的commit的内容

=========到 >>>>68的是您下拉的内容
```

### Git修改远程仓库地址
```


背景：Github 将https方式改为ssh方式，进行push与clone

使用Git提交到Github时，若采用默认的https方式进行push与clone，则会比较慢，且对大文件容易出现报错的情况，故我们可以将其改为ssh方式

步骤

1.打开Github的仓库，点击code，进入显示ssh的页面

2.到本地项目文件夹子，打开git bash。查看clone 地址：git remote -v

3.移除https的方式 git remote rm origin

4.添加新的git方式：ssh方式，ssh方式地址的话，在github上，切换到ssh方式，然后复制地址。

5.git remote add origin 刚刚复制的git地址

6.git remote -v

看到地址是以git@github.com:开头，说明ssh方式添加成功

7.重新push（提交一下）

git push origin maste

8.完成以上步骤，便由https方式改为了ssh方式。

```


### Git more ssh-key


```

背景：当有多个git账号时，比如：

a. 一个gitee，用于公司内部的工作开发；
b. 一个github，用于自己进行一些开发活动；

解决方法
    1.生成一个公司用的SSH-Key
        $ ssh-keygen -t rsa -C 'xxxxx@company.com' -f ~/.ssh/gitee_id_rsa
    2.生成一个github用的SSH-Key
        $ ssh-keygen -t rsa -C 'xxxxx@qq.com' -f ~/.ssh/github_id_rsa
    3.在 ~/.ssh 目录下新建一个config文件，添加如下内容（其中Host和HostName填写git服务器的域名，IdentityFile指定私钥的路径）
        # gitee
        Host gitee.com
        HostName gitee.com
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/gitee_id_rsa
        # github
        Host github.com
        HostName github.com
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/github_id_rsa
    4.用ssh命令分别测试

        $ ssh -T git@gitee.com
        $ ssh -T git@github.com


    或者
    
    1.生成一个公司用的SSH-Key
        $ ssh-keygen -t rsa -C 'xxxxx@company.com' 
    2.生成一个github用的SSH-Key
        $ ssh-keygen -t rsa -C 'xxxxx@qq.com' -f ~/.ssh/github_id_rsa
    3.在 ~/.ssh 目录下新建一个config文件，添加如下内容（其中Host和HostName填写git服务器的域名，IdentityFile指定私钥的路径）
        # github
        Host github.com
        HostName github.com
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/github_id_rsa
    4.用ssh命令分别测试
        $ ssh -T git@github.com

```
    (4) Git操作
    
    ssh-key
    
    ssh-keygen -t rsa -C "$your_email"          # 获取 sshkey
    cat ~/.ssh/id_rsa.pub                      # 查看 sshkey





### 子模块(submodule)
```
git submodule foreach git pull    子模块更新



git子分支：
git submodule init
git submodule update

获取子分支的commit id
git submodule

添加子模块

git submodule add [repository-url] [local-path]

进入子模块目录，将子模块回滚到指定commit版本

git reset --hard [commit-number]
```



### 远程分支被别人删除了，本地还有显示



```text

要删除本地，可使用如下命令：
git remote prune origin
git fetch --prune

```

### [#](http://www.xiaoxiaoguo.cn/tools/git-01.html#恢复被删除的文件)恢复被删除的文件



```text

如果清楚知道commit_id ，使用如下命令

git checkout commit_id -- file_name

不加commit_id时，则会将该文件恢复到最新提交的那次

```





### 首次使用 git


```bash
客户端首次使用 git 提交时需要将 id_rsa.pub 内容提交到 github 上不然每次都会提示输入用户名密码

然后输入必要的配置


git config --global user.name wxnacy            # 配置用户名
git config --global user.email xxx@qq.com      # 配置邮件
git config --global push.default simple
git push -u origin master


初始化项目

cd project_root                            # 进入项目目录
git init                                    # 初始化git仓库
git add .                                  # 添加文件到仓库
git commit -m 'init commit'                # 提交代码到本地仓库
git remote add origin ${repository_path}    # 将项目关联到git server
git pull origin master                      # 同步代码
git push origin master                      # push代码到远程仓库
git clone ${repository_path}                # 新的位置clone项目





删除文件

rm -r file_path
git rm -r ${file_path}
git commit -m 'remove'
git pull origin master
git push origin master





用户信息

git config --global user.name wxnacy            # 配置用户名
git config --global user.email xxx@qq.com      # 配置邮件

$ git config user.name      # 查看登录名
$ git config user.email    # 查看登录邮箱





记住密码

在服务器上 clone 代码第一次通常会提示输入密码，为了下次不再提示，可以在 clone 后做如下操作

git config credential.helper store



撤销操作

重新提交

提交后如果发现遗漏可以使用 git commit --amend 重新提交

git commit -m 'initial commit'
git add forgotten_file
git commit --amend





撤销提交文件

git checkout --               # 取消对文件的修改。还原到最近的版本，废弃本地做的修改。
git reset HEAD ...            # 取消已经暂存的文件。即，撤销先前"git add"的操作
git reset HEAD^                    # 回退所有内容到上一个版本
git reset HEAD^ a.py                # 回退a.py这个文件的版本到上一个版本
git reset –soft HEAD~3              # 向前回退到第3个版本
git reset –hard origin/master      # 将本地的状态回退到和远程的一样
git reset 057d                      # 回退到某个版本
git revert HEAD                    # 回退到上一次提交的状态，按照某一次的commit完全反向的进行一次commit.(代码回滚到上个版本，并提交git)
git merge --abort                  # 撤销所有合并操作

或者

git -c core.quotepath=false rm --cached -f -- env.sh
git -c core.quotepath=false checkout HEAD -- env.sh


修改remote url

git remote set-url origin ${new_repository_path}


分支

git checkout -b ${new_branch} master    # 从master创建新分支
git checkout ${branch_name}            # 定位分支
git checkout -b {local-branch-name} origin/{remote-branch-name} # 从远程分支创建新分支
git merge --no-off ${branch_name}      # 将其他分支合并到master
git rebase origin master # master分支合并到当前分支
git pull origin {branch-name}          # 拉取远程分支



标签

git tag ${tag_name} master              # 创建新分支
git push origin ${tag_name}            # 将标签推到远程仓库
git branch -D ${branch_tag_name}        # 删除本地分支或标签
git push origin :${branch_tag_name}    # 删除远程分支或分支





提交检查

在代码提前前或查看提交记录详情时可能会用到下面几组命令

status

git status          # 查看当前版本状态（是否修改）



log

git log            # 显示提交日志
git log -1          # 显示1行日志 -n为n行
git log --stat      # 显示提交日志及相关变动文件
git log -p -m      # 显示提交日志及变动的详细情况
git log v2.0        # 显示v2.0的日志


show

git show dfb02e6e4f2f7b573        # 显示某个提交的详细内容
git show dfb02                    # 可只用commitid的前几位
git show HEAD                      # 显示HEAD提交日志
git show HEAD^                    # 显示HEAD的父（上一个版本）的提交日志 ^^为上两个版本 ^5为上5个版本
git show v2.0                      # 显示v2.0的日志及详细内容


diff

git diff                                  # 显示所有未添加至index的变更
git diff --cached                        # 显示所有已添加index但还未commit的变更
git diff HEAD^                            # 比较与上一个版本的差异
git diff HEAD -- ./lib                    # 比较与HEAD版本lib目录的差异
git diff origin/master..master            # 比较远程分支master上有本地分支master上没有的
git diff origin/master..master --stat    # 只显示差异的文件，不显示具体内容







新建代码库

    # 在当前目录新建一个Git代码库
    $ git init

    # 新建一个目录，将其初始化为Git代码库
    $ git init [project-name]

    # 下载一个项目和它的整个代码历史
    $ git clone [url]

配置 config

    --global 代表全局变量
    # 显示当前的Git配置
    $ git config --list

    # 设置提交代码时的用户信息
    $ git config [--global] user.name "[name]"
    $ git config [--global] user.email "[email address]"

git add 添加
    # 添加指定文件到暂存区
    $ git add [file1] [file2] ...

    # 添加指定目录到暂存区，包括子目录
    $ git add [dir]

    # 添加当前目录的所有文件到暂存区
    $ git add .

    # 添加每个变化前，可以查看确认变化
    # 对于同一个文件的多处变化，可以实现分次提交
    $ git add -p

git rm 删除
    # 停止追踪指定文件，但该文件会保留在工作区
    $ git rm -r --cached [file]

git mv 改名
    # 改名文件，并且将这个改名放入暂存区
    $ git mv [file-original] [file-renamed]

git commit 提交

    # 提交暂存区到仓库区
    $ git commit -m [message]

    # 提交暂存区的指定文件到仓库区
    $ git commit [file1] [file2] ... -m [message]

    # 提交时显示所有diff信息
    $ git commit -v

    # 使用一次新的commit，替代上一次提交
    # 如果代码没有任何新变化，则用来改写上一次commit的提交信息
    $ git commit --amend -m [message]

    # 重做上一次commit，并包括指定文件的新变化
    $ git commit --amend [file1] [file2] ...

git branch 分支

    # 列出所有本地分支
    $ git branch

    # 列出所有远程分支
    $ git branch -r

    # 列出所有本地分支和远程分支
    $ git branch -a

    # 列出本地分支追踪的远程分支
    $ git branch -vv

    # 切换到指定分支，并更新工作区
    $ git checkout [branch-name]

    # 切换到上一个分支
    $ git checkout -

–set-upstream --track 建立追踪

    $ git branch --set-upstream [branch] [remote-branch]
    # 本地分支追踪远端dev分支
    $ git branch --set-upstream-to=origin/dev

    # 新建一个分支，与指定的远程分支建立追踪关系
    $ git branch --track [branch] [remote/branch]


新建分支

    # 新建一个分支，但依然停留在当前分支
    $ git branch [branch-name]

    # 新建一个分支，并切换到该分支
    $ git checkout -b [branch]

    # 新建一个分支，指向指定commit
    $ git branch [branch] [commit]

merge cherry-pick 合并

    # 合并指定分支到当前分支
    $ git merge [branch]

    # 选择一个commit，合并进当前分支
    $ git cherry-pick [commit]

删除分支

    # 删除分支
    $ git branch -d [branch-name]

    # 删除远程分支
    $ git push origin :branch-name

更改远端仓库

    $ git remote set-url origin git@github.com:youzi-yun/miniORM_Flask.git

合并 commit

    $ git reset --soft HEAD~1
    $ git commmit --amend

git tag

    # 列出所有tag
    $ git tag

    # 新建一个tag在当前commit
    $ git tag [tag]

    # 新建一个tag在指定commit
    $ git tag [tag] [commit]

    # 删除本地tag
    $ git tag -d [tag]

    # 删除远程tag
    $ git push origin :refs/tags/[tagName]

    # 查看tag信息
    $ git show [tag]

    # 提交指定tag
    $ git push [remote] [tag]

    # 提交所有tag
    $ git push [remote] --tags

    # 新建一个分支，指向某个tag
    $ git checkout -b [branch] [tag]

    #删除所有本地tag
    git tag -l | xargs git tag -d 

查看信息

    # 显示有变更的文件
    $ git status

    # 显示当前分支的版本历史
    $ git log

    # 显示commit历史，以及每次commit发生变更的文件
    $ git log --stat

    # 显示某个commit之后的所有变动，每个commit占据一行
    $ git log [tag] HEAD --pretty=format:%s

    # 显示某个commit之后的所有变动，其"提交说明"必须符合搜索条件
    $ git log [tag] HEAD --grep feature

    # 显示某个文件的版本历史，包括文件改名
    $ git log --follow [file]
    $ git whatchanged [file]

    # 显示指定文件相关的每一次diff
    $ git log -p [file]

    # 显示过去5次提交
    $ git log -5 --pretty --oneline

    # 显示所有提交过的用户，按提交次数排序
    $ git shortlog -sn

    # 显示指定文件是什么人在什么时间修改过
    $ git blame [file]

    # 显示暂存区和工作区的差异
    $ git diff

    # 显示暂存区和上一个commit的差异
    $ git diff --cached [file]

    # 显示工作区与当前分支最新commit之间的差异
    $ git diff HEAD

    # 显示两次提交之间的差异
    $ git diff [first-branch]...[second-branch]

    # 显示今天你写了多少行代码
    $ git diff --shortstat "@{0 day ago}"

    # 显示某次提交的元数据和内容变化
    $ git show [commit]

    # 显示某次提交发生变化的文件
    $ git show --name-only [commit]

    # 显示某次提交时，某个文件的内容
    $ git show [commit]:[filename]

    # 显示当前分支的最近几次提交
    $ git reflog

远程同步

    # 下载远程仓库的所有变动
    $ git fetch [remote]

    #从远程拉取所有信息
    git fetch origin --prune

    # 显示所有远程仓库
    $ git remote -v

    # 显示某个远程仓库的信息
    $ git remote show [remote]

    # 增加一个新的远程仓库，并命名
    $ git remote add [shortname] [url]

    # 取回远程仓库的变化，并与本地分支合并
    $ git pull [remote] [branch]

    # 上传本地指定分支到远程仓库
    $ git push [remote] [branch]

    # 强行推送当前分支到远程仓库，即使有冲突
    $ git push [remote] --force

    # 推送所有分支到远程仓库
    $ git push [remote] --all

git checkout 撤销

    # 恢复暂存区的指定文件到工作区
    $ git checkout [file]

    # 恢复某个commit的指定文件到暂存区,git log 不变
    $ git checkout [commit号] [file]

    # 撤销所有修改（未add）
    $ git checkout .

    # 撤销指定文件修改（未add）
    $ git checkout -- [file]

git reset 重置

    # 重置暂存区的指定文件，与上一次commit保持一致，但工作区不变
    $ git reset [file]

    # 重置暂存区与工作区，与上一次commit保持一致
    $ git reset --hard

    # 重置当前分支的指针为指定commit，同时重置暂存区，但工作区不变
    $ git reset [commit]

    # 重置当前分支的HEAD为指定commit，同时重置暂存区和工作区，与指定commit一致
    $ git reset --hard [commit]

    # 重置当前HEAD为指定commit，但保持暂存区和工作区不变
    $ git reset --keep [commit]

    # 新建一个commit，用来撤销指定commit
    # 后者的所有变化都将被前者抵消，并且应用到当前分支
    $ git revert [commit]

git stash 缓存

    # 将修改的内容放入缓存区，可以切分支
    $ git stash

    # 取出缓存区中stash{0}的内容，并删除缓存区的文件
    $ git stash pop stash@{0}

    # 恢复到以前的工作状态
    $ git stash apply

    # 查看当前stash情况
    $ git stash list

    $ git stash apply stash@{1} 命令来使用在队列中的任意一个'储藏'(stashes).

    # 清空这个队列
    $ git stash clear

```