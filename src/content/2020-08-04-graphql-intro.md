---
templateKey: blog-post
id: graphql-intro
title: graphqllearing review
slug: /2020/08/04/graphql-learning-review
date: 2020-08-04T07:48:03.125Z
description: 总结
headerImage: https://i.imgur.com/mich3dS.jpg
tags:
  - graphql, nodejs
---

Graphql是API的查询语言，又是执行query的服务端运行时。
它定义数据的类型系统。通过定义类型的类型和fields来创建graphql服务。
然后为每个类型的每个域提供函数。
一旦service启动，它就可以接受graphql queries进行验证和执行。先验证确保只引用了
定义的类型和fields，然后运行提供的函数产生结果。

### 为什么说Graphql可以完全的替换多次API请求？
Graphal不仅可以通过参数对结果进行控制，每一个field和内置对象都可以有自己的参数。


Graphql基本上是选择对象上的fields的

Graphql service定义一组类型，完全的描述可在该service上查询的数据。

graphql的对象类型，描述的是从service上获取的一类对象以及对象应该有哪些fields

schema里的大多数类型是Object类型，有两种特殊类型 query和mutation。
graphql必须有query，定义的是每一个Graphql query的入口。

Input类型和对象类型一样，只不过是INput开头


类型系统的使用可以预先判断graphql的query是否有效，而不是依赖runtime检查。


Graphql server执行Graphql query，将结果映射为query的结构返回。


graphql的interface规定的是一个类型必须有同样的域

graphql query的每一个field当作函数或者之前类型的方法-他返回下一个类型

Graphql Server提供resolver函数来支持类型的域的。当一个域执行的时候，对应的resolver
会被调用产生新的value。


### how Graphql works？
如果field产生的是scalar 值，那么执行就算结束了。如果field产生的是对象值， query
将继续执行内部查询，直到找到scalar。



![FYI](https://i.imgur.com/kqA9hFb.jpg)

