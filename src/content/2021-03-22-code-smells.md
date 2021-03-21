---
templateKey: blog-post
id:code-smells
title: refactoring 第二弹
slug: /2021/03/22/code-smells/
date: 2021-03-22T03:48:03.125Z
description: 学习一些重构相关的知识
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - refactoring, code smells
---

### code smells
#### bloaters (臃肿)
臃肿是code，方法和类已经增长到巨大的比例以致于很难去使用。通常这些臭味
不会突然出现，而是随着时间程序的不断壮大慢慢积累，特别是在没有人努力去去除的
情况下。

##### 长方法
一个方法包含了太多行code。通常，任何超过十行的方法都应该问下方法是不是臃肿了。
##### 大的类
一个类包含了太多的field，方法和code行数
##### 基本类型过度使用
- 使用了基本类型而不是小对象来服务简单的任务(比如并发，范围，电话号的特殊字符串等等);
- 编码信息常量的使用(比如常量USER_ADMIN=1来指代用户有管理员权限)
-使用字符串常量作为field那么用在数组里
##### 长参数列表
一个方法的参数多于三到四个
##### 数据团块
有时候code里的不同部分报案者同样的好多组变量(比如连接到数据库的参数)。这些块应该转变
成自己的类

