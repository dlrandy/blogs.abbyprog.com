---
templateKey: blog-post
id: graphql-intro
title: graphql 入门
slug: /2020/08/18/graphql-intro/
date: 2020-08-18T03:48:03.125Z
description: graphql入门介绍
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - graphql
---

### 基于端点的APIs
一般是围绕着http端点的架构，可能是基于http的JSON API，RPC或者REST等。
#### 优势
1. 易于实现
2. 对特定的情况易于优化
3. 客户端容易缓存，易于发觉，易于客户端使用
#### 劣势
对于不同的client同一个API可能有不同的需求的时候，要做的细节工作就比较多；
结果就是一刀切/一体适用(one-size-fits-all)
> 针对这种API不同的使用场景的情况，最简单的办法是：
  - 增加更多的端点，每种变化一个端点
  - 增加一个参数来进行识别
  - client使用JSON:API来说明自己需要那些字段
  它们的共性在于都是在优化和自定义之间进行权衡。原因在于OSFA(一体适用)的
  方法方便于API的提供者，而不是使用者。
**Netflix的做法**
在client和server之间加一个中间层，进行适配和格式化不同的数据不同的client，
**SoundCloud**
不同的使用情况，设置不同的server
### Graphql
它是一种方案，不是简单的替换基于端点的http APIs也不是Next Rest。
它是构建API的方案，解决的是基于API的构建体验的挑战，重新定义了client
和server之间的挑战。
> Graphql是一个API查询语言的规范，是一个能够执行这些查询的server引擎

### graphql的fields
可以把fields当作是一个函数，既可以接收参数又可以返回特定的类型
### Type System（schema）
任何Graphqlserver的核心都是一个强大的类型系统，帮助描述API的能力
SDL是正统的描述schema的工具。它是跨语言的。

### Types和Fileds
graphql schema最基本和重要的基础是Object类型。
它描述的是Graphql APi里的一个概念。自身没有什么用，但是在
它定义field的时候，就有用了。
> Graphql server 执行Fields，然后返回对应类型的值。Graphql server可以执行这种query，是因为在query的每一个级别里，它能够将用户的需求和已知的schema进行验证

### schema Roots
作为查询的入口点。


### arguments
field可以定义参数来影响field的运行时解析。
它可以定义一个类型，该类型可以是Scalar类型也可以是Input类型

### variables
client将变量和query一起发送给Graphql server来执行，而不是将变量
直接包含在query string里。
### alias
多用于查询使用不同的参数查询同样的field的时候

### Mutations
主要是写和修改数据的。它的入口点是mutation root

Mutation VS query
- Mutation的顶级field允许有side effects
- mutation的顶级的field顺序执行，其他field并行执行
### Enums
适合一组特定的值，具有描述性

### 抽象类型
他不是具体的类型，代表着的某种类型。
主要的使用方式是interface(约定) 和unions（不同类型的合集）
因为它定义的是可能的实体类型，所以client需要指定哪些实体类型是需要的。

### Fragments
定义query可复用的部分
inline fragment ：... on Certain Type
显示的fragment：fragment ProductFragment on Product{
  name
  price
  variants
}
