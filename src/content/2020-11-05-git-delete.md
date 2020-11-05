---
templateKey: blog-post
id: git-delete
title: git delete branch 的相关操作
slug: /2020/11/05/git-delete/
date: 2020-11-05T03:48:03.125Z
description: git 删除本地和远程分支的各种操作
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - git, delete, branch, remote
---

### 什么时候删除分支？
修复或者特性完成的时候，建议去删除分支

### git 删除本地分支和远程分支
``` bash
# local
git branch -d/ -D branch_name
# -D为强制删除
# remote
git push <remote> --delete branch_name
# e.g. git push origin --delete branch_name
# 列出远程删除的分支 这些分支会有gone的标志
git fetch -p 
```

### **批量** 清除本地那些已经在远程删除了的分支
``` bash
git fetch -p && git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -D
# git fetch -p
# 获取最新的远程分支信息，-p是移除远端不存在的远程追踪引用
# git branch -vv
#  列出本地分支在远程仓库的状态
# grep 'origin/.*: gone]'
# 查询远程不存在的分支
# awk '{print $1}'
# 选择分支名字
# xargs git branch -D
# 移除本地的这些分支

alias.gitgone="git fetch -p && git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | xargs git branch -D "

``` 

### 删除已合并的分支

``` bash
# 删除本地已合并的分支
# 切到master或者dev分支， 会删除所有已合并到当前分支的其他分支
git branch --merged | grep -v '\*\|main\|master\|develop' | xargs -n 1 git branch -d

# 删除远程已经合并的分支
git branch -r --merged | grep -v '\*\|main\|master\|develop' | sed 's/origin\///' | xargs -n 1 git push --delete origin 
git fetch -p

```

### 删除远程分支的本地引用
``` bash 
# 列出本地可以删除分支的引用
git remote prune origin --dry-run
# 删除本地引用
git remote prune origin
```

### SVN  VS  Git
SVN是单一的中心化仓库作为开发者之间的通信中介，协作是通过在开发中的工作拷贝和中心仓库传递改变集。
GIT是分布式的协作模型，每个开发者有自己的仓库拷贝，完全有自己的本地历史和分支结构。用户共享的一系列的commit而不是单一改变集。不是提交工作目录拷贝的改变集到中心仓库，而是在仓库之间共享整个分支。


### git remote
主要是创建和查看和删除和其他的仓库的关联。
``` bash
# 查看git remote的远程配置
git remote -v
# 创建git remote
git remote add <name> <url>
# 删除git remote
git remote remove <name>
# 修改git remote
git remote rename <old-name> <new-name>

```

#### 讨论
git是用来给开发者完全独立的开发环境。也就是说信息不会自动的在仓库之间来回的传送。

















