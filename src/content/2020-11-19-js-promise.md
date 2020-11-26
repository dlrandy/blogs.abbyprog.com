---
templateKey: blog-post
id: promise-polyfill
title: 手写promise
slug: /2020/11/19/manual-promise/
date: 2020-11-19T03:48:03.125Z
description: 了解Promise
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - promise,manual
---

promise代表着一个操作(异步)的结果，它是value的包装器，但是在未来可能能用可能不能用。
但是开发者可以像这个值已经存在一样使用这个包装器。

promise一旦fullfilled或者rejected，它的值和状态就不能进一步改变。

原生promise是不能够随意的访问promise的内部state和value的。
它把数据存储在内部的slots里，用户领域是不能够复制internal slots的。



