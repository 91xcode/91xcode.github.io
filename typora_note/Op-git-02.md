@[TOC](这里写自定义目录标题)

# git

## 需求

>   git日常使用备注



## [Clone](https://sigoden.github.io/mynotes/tools/git.html#clone)

```

# branch
git clone -b dev https://github.com/org/repo.git
# target folder
git clone https://github.com/org/repo.git myrepo 
# contains submodule
git clone --recurse-submodules https://github.com/org/repo.git
# abaddon history
git clone --depth=1 https://github.com/org/repo.git
```

## [Branch](https://sigoden.github.io/mynotes/tools/git.html#branch)

```

# list branches
git branch
# list remote branches
git branch -r
# list all branches
git branch -a
# create branch
git checkout -b feat1
# rename a branch
git branch -m newname
# checkout branch
git checkout feat1
# checkout remote branch
git checkout -t origin/dev
# delete branch
git branch -d feat1
# delete branch forcedly
git branch -D feat1
# delete branch of remote repo
git push origin :feat1
```

## [Tag](https://sigoden.github.io/mynotes/tools/git.html#tag)

```

# list tags
git tag
# create tag
git tag v1.0.0
# delete tag
git tag -d v1.0.0
# delete tag forcedly
git tag -D v1.0.0
# delete tag of remote repo
git push origin :v1.0.0
```

## [Fetch](https://sigoden.github.io/mynotes/tools/git.html#fetch)

```

# pull changes
git fetch
# pull github pr
git fetch origin pull/ID/head:BRANCH_NAME
# pull changes and prune none-exist remote branches
git fetch --purge
```

## [Snippets](https://sigoden.github.io/mynotes/tools/git.html#snippets)

```

# merge last commit
git commit --amend
# sync submodule
git submodule update --init --recursive
# inspect remote url
git remote -v
# change remote url
git remote set-url origin $new_repo
```



## [Config](https://sigoden.github.io/mynotes/tools/git.html#config)

### [User](https://sigoden.github.io/mynotes/tools/git.html#user)

```

git config --global user.name $user
git config --global user.email $email
```

### [Ignore](https://sigoden.github.io/mynotes/tools/git.html#ignore)

```

设置全局的.gitignore
# linux/macos
git config --global core.excludesFile '~/.gitignore'
# windows
git config --global core.excludesFile "$env:USERPROFILE\.gitignore"
```

### [Cjk path](https://sigoden.github.io/mynotes/tools/git.html#cjk-path)

```

如果你有一个名为文件.txt（含有中文字符）的文件，开启quotepath后，在命令行中会显示为类似"\344\270\255\344\272\224.txt"，而设置为false后，就会显示为原始的文件.txt。

git config --global core.quotepath false
```

### [CRLF](https://sigoden.github.io/mynotes/tools/git.html#crlf)

```

这两个配置的组合有助于在跨平台项目中维护一致的行结束符，防止因为行结束符的差异导致不必要的差异和合并冲突。

git config --global core.eol lf
git config --global core.autocrlf input
```















