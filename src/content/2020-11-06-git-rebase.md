---
templateKey: blog-post
id: git-rebase
title: git rebase 的相关操作
slug: /2020/11/06/git-rebase/
date: 2020-11-06T03:48:03.125Z
description: git rebase的各种操作
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - git, rebase
---

### 先抛出一个问题
目前的开发状况：
``` bash
a---b---c---d---e---f  master
     \
      g---h---i  feature-1
               \
                j---k---l---m  feature-2
```
但是feature-1rebase了master
``` bash

a---b---c---d---e---f  master
    |                \
    |                 g'--h'--i'  feature-1
     \
      g---h---i---j---k---l---m  feature-2
```
如何让feature-2变基到feature-1?
``` bash
a---b---c---d---e---f  master
                     \
                      g'--h'--i'  feature-1
                               \
                                j'--k'--l'--m'  feature-2

```
### rebase 是如何工作的？
在另一个base上重新进行commit。

``` bash
git rebase <newbase>

git rebase --onto <newbase> <oldbase> <end>

```
它是将一个分支的改变整合到另一个的两种方式之一。另一个是merge。
merge总会产生新的commit。rebase是会重写提交的历史的。



注意已经合并的分支，就不要再rebase了。


