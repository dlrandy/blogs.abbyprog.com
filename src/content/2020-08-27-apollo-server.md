---
templateKey: blog-post
id: Apollo Server
title: graphql Apollo Server
slug: /2020/08/27/graphql-apollo-server
date: 2020-08-27T07:48:03.125Z
description: apollo server 小记
headerImage: https://i.imgur.com/mich3dS.jpg
tags:
  - graphql, nodejs, apollo, server
---


### DataSources
本身是从一个特殊的服务上获取数据的service类；内置缓存，去重和错误处理的功能。存放和
后端交互的代码的地方。

#### 种类
1. REST Data Source
  支持fetch拦截

#### 应用
主要由resolver调用来获取后端数据的


### DataLoader
用来去重和批处理某个数据store里的多个对象负载；
DataLoader适合批处理的情况。需要注意的是如何将Graphql放在rest API层之上的话，注意缓存。
建议限制不能缓存的批处理。

### Error handling
Apollo提供了一些预定义的错误，在graphql执行之前或者中间执行。
 
![FYI](https://i.imgur.com/kqA9hFb.jpg)


 ·