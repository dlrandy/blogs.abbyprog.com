---
templateKey: blog-post
id: graphql-ast
title: 理解graphql
slug: /2020/11/13/graphql-ast/
date: 2020-11-13T03:48:03.125Z
description: 了解一下graphql与AST的关系
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - graphql, ast
---

为了解释和理解唯一且复杂的请求，graphql使用AST来组织到来的请求。方便后端解析和构造需要的响应。

Graphql是规范，不知最后的数据源。因此需要graphql-js和graphql-tools来处理繁重的工作--抽离出和底层ast交互的地方。

### AST
它是重度内嵌的对象，这个结构有compiler来解析，转换成树结构，来变成遍历

当用户发送请求的时候， Graphql将用户的查询文档和resolver里定义的schema以AST的形式进行合并。这个AST用来决定请求哪个field，哪个参数被包含等等。

研究AST源于写自定义指令和优化用户请求：
分解graphql 生命周期，在到达另一个lib生成数据响应之前拦截请求 


遍历和强化AST，可以实现：
 - schema 拼接 (shcema stiching)
 - 自定义指令 (custom directives)
 - 饱满的查询 (enriched queries)
 - 层次化抽象 (layered abstraction)
 - 更多的后端magic (more backend magic)

 caching的问题
 常见的解决方案是缓存结果使用唯一的AST field 选区的字符串版本。

 ### graphql VS rest
 1. 没有rest的过度获取和获取不足的问题
 