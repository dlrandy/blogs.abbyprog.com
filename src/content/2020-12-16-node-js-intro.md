---
templateKey: blog-post
id:nodejs-intro
title: nodejs 入门
slug: /2020/12/16/nodejs-intro/
date: 2020-12-16T03:48:03.125Z
description: 初步认识nodejs和js
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - nodejs, js
---

### graphql
它是查询APi的协议。可以精准的返回用户需要的数据；一次请求
可以拿到所有需要的数据。
> graphql不指定要使用的Protocol，http可以，tcp也可以

### graphql schema
描述graphql server可以进行的交互。


### grpc
类REST的模式或者一定程度上的Graphql，都是在试图抽离producer提供的
底层功能，本质上是暴露数据和CRUD操作相关的API。
> 使用HTTP提供的methods不能够很好的描述app的功能

Http提供了有限的动词，RPC可以使用任何的动词
RPC不是创建不同的接口，而是直接以原生的形式暴露方法给网络。
> RPC是选择app里的哪些功能暴露出去，并在暴露的功能和网络接口
之间创建映射。(接受什么样数据，接受谁的数据)

GRPC 通常是运行在H2上的，Graphql暴露一个接口，grac则是根据调用的
方法决定接口。它传输的数据格式是ProtoBuf。

### Protocol Buffers 和 GRPC
Protocol Buffer是对象的二进制序列格式；这种描述带有更少的消息负载，也减少了
每个message的冗余信息，使得网络性能更好。

**为什么说message的field的数字很重要？**
1. field 的名字不会随着message传输
  因为schema是共享的，所以field的名字是冗余的。
2. field的顺序，是用来向后兼容的





> MessagePack是可选的替代格式，层级对象数据的二进制描述
，更多是来替换json的。
Grpc是RPC模式的跨平台实现。

ApacheThrift是ProtoBuf和grpc的替代方案；
JSON RPC是另一外一种。




