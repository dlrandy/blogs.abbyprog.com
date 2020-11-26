---
templateKey: blog-post
id: mutation-observer
title: 理解graphql
slug: /2020/11/24/graphql-ast/
date: 2020-11-24T03:48:03.125Z
description: mutationObserver的学习了解
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js, mutationObserver
---

MutationObserver 观察DOM元素，当DOM元素有变化的时候，触发回调。

应用：
- 整合
 比如整合第三方应用的时候，第三方会带来一些不想要的东西，比如Ads，哪些页面上这些不想要的DOM就可以移除掉。
- 架构
 检测dom结构，整体处理，而不是逐一处理， 比如动态高亮的例子

 方法: 
 new MutationObserver((mutations)=>{})
 observer.observer(node, config)
 observer.disconnect()
 observer.takeRecords() // 它返回的记录会从mutation队列里移除的

 **它和垃圾回收的关联**
Observer内部使用的是弱引用的node。如果节点从DOM中移除，变成了unreachable的，节点是可以被回收的。也就是说Observer不会阻止观察的node被回收。

### 总结
MutationObserver响应ODM的变化--包括属性，文本和增加删除元素。但是注意它的配置，配置是用来优化的，不要花资源在不需要的回调调用上。





https://javascript.info/mutation-observer
https://www.smashingmagazine.com/2019/04/mutationobserver-api-guide/