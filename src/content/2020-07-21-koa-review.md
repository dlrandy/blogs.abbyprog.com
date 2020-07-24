---
templateKey: blog-post
id: koa-review
title: 读Koa 源码收获
slug: /2020/07/21/koa-source-review/
date: 2020-07-21T03:48:03.125Z
description: 记录一下读koa源码的收获
headerImage: https://i.imgur.com/IONCWVd.jpg
tags:
  - koa, js
---

## 记录

### 关于async 与generator的实现与转换

### koa  vs  express
1. 中间件
  1. express的中间件是基于回调的；koa是基于promise的
  2. 在省略了next调用的情况下，express的request可能会阻塞，
    如果没有设置res.end()的情况下；koa则是下一个中间不会执行，整个request还是会结束的。
  3. koa的中间件是普通函数的时候，注意加上返回值；
  4. koa的错误处理在中间件的顶端；express的错误处理则在中间件的最低端。
2. express适合中小型的；koa适合大型的；
3. koa要自己选择插件；express自带一些插件；
4. koa的性能相对express好一些
5. express是继承并添加了一些对象给原生node的req和res对象；koa则是使用context
替换了原生的noderequest和response。




### lodash之get实现
简单的可写，完全的功能写不出来，难点在于转换路径的时候。
思想就是路径转换成数组，一层一层的找，如果发现不存在了，就是属性值为undefined；
如果找到了最后，索引等于路径长度的时候，切属性值存在，那就是value存在；否则undefined。
https://github.com/lodash/lodash/blob/master/get.js#L13


![FYI](https://i.imgur.com/LalbenT.jpg)




