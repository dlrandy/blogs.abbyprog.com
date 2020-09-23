---
templateKey: blog-post
id: graphql-schema-design
title: graphql schema design
slug: /2020/08/19/graphql-schema-design
date: 2020-08-19T07:48:03.125Z
description: 总结
headerImage: https://i.imgur.com/mich3dS.jpg
tags:
  - graphql, nodejs, schema, design
---


Graphql API的关键是正确的设计这些可能性。

### 什么造就了好的API
APIs易于使用，难于误用。能这么做的根本就是design。
Graphql本身并不能使得API的设计容易。虽然强大的type system，但是使用的不对的话，
仍然会有其他API风格的问题。

### design first
在开始实现之前，想好设计会产生更好的API。不这么做可能会导致内部实现耦合严重。
良好的设计需要领域的从业人员或者专家和开发者一起参与的。
最一开始做设计的时候，确保理解了

### client first
Graphql是用户为中心的API。首先要根据用户的使用情况设计Graphql API。
这么做确保了API满足了用户的需求，而且这种设计使得API易于使用，难于误用。
不这么做会使得用户猜测和读取文档来达到想要的，更糟的是有时候并不能使用。

这种设计几点要求：
- 较早的将设计分享给client，让client尽可能快的整合。
- Client first并不意味着完全的做client想要的
- API是完整的，意味着API提供足够的特性给client来达到需要的使用情况，不要暴露其他的东西
- 设计schema不要受到实现细节的影响，就是使用API的人不会关心使用的数据库，程序语言，或者有什么设计问题

Graphql 的schema是功能的入口点，应该避免和后端的实现细节紧绑。有时候可用性和性能可能会指示设计。


Graphql的typed 特性，吸引着很多的厂商和工具提供数据库或者其他数据源的Graphql的API。这些工具
只是用于在数据库层上快速原型Graphql 层。


Rest和Graphql有不同的设计关注点

### Great API
1. 命名 好的命名会传递出API功能的信息
  > 最基本的要保持一致性(方法名，domain名)
2. API的对称性，比如publishPOST对应unPublishPost
3. 应该具体的命名schema成员 避免client迷惑field或者对象到底是在干什么
4. descriptions 使用三个双分号作为描述，方便client使用graphiql搜索API
 > 正常来说应该描述schema里所有的实体，因为可以清晰的传递schema类型的作用，但是太多的描述，又揭露出设计的不足。使用API的client，并不用必须读description。底线就是不要要用户依赖description去理解用例
5. 使用schema设计API

### 设计schema 易于犯的错误
1. field的类型不具描述性
2. 完全非结构化的的数据作为schema的部分
3. 使用自定义的scalar类型或者string。在大多数情况下，都应该使用强类型的schema

### 使得schema易于使用和理解的方式
1. 确保field只做好一件事情，可能的话尽量避免通用的fields
2. 在schema可以强化的情况下，尽量避免运行时逻辑
3. 使用复杂的对象和输入类型来描述fields和arguments的耦合
4. 在使用可选的input或者argument的时候，使用默认值


### specific VS generic
Graphql的核心理念就是让client完全的使用他们所需要的。field应该只做
一件事，并将这件事做好。这样也有利于cache。
选择S还是G取决于构建API的种类

### Anemic Graphql
以纯作为数据包的方式设计schema，而不是以actions，use cases或者功能来思考。

### Pagination
两种主要方式：
1. offset pagination

2. cursor pagination

 
![FYI](https://i.imgur.com/kqA9hFb.jpg)


 ·