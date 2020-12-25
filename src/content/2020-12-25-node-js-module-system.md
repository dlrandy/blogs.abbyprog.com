---
templateKey: blog-post
id:nodejs-module-system
title: 了解nodejs的模块系统和相关模式
slug: /2020/12/25/nodejs-modules/
date: 2020-12-25T03:48:03.125Z
description:了解nodejs的模块系统和相关模式
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - nodejs, design,pattern
---

### 谈及模块的时候，模式到底意味着什么？为什么它们很重要？
模块是构建APP的基石。
module将codebase分成可独立开发测试的单元。
模块可以强化信息的隐藏，通过将私有的函数和变量不显示导出。

> module和其他语言的package(Java go dart),assembly(.net),library(ruby),unit（pascal）等概念相似，，但是不是等价的，一般是有特殊，有重叠。
**nodejs有两个模块系统，Commonjs(CJS)和ES modules(ESM)**

### 为什么需要模块
模块系统满足了一些软件工程的需要：
1. 将codebase分为多个文件
  有助于组织code，使得code易于理解，有助于独立的开发和测试各种功能。
2. 允许code在不同的项目里复用
3. 封装(信息隐藏)
  隐藏实现的复杂性，暴露出简单易用的接口。
4. 管理依赖
  好的模块系统应该易于在已有模块上构建功能。

### Modules  VS Module System
module是软件的实际unit；模块系统则是允许在项目里定义和使用模块的语法和工具。


### js 模块 和nodejs 模块
- [ ] 浏览器里通过script标签,Amd,CMD,Umd，Esm划分
- [ ] nodejs里使用commonjs，ESM


### 模块系统和它的模式
因为浏览器里没有命名空间，全局的变量容易产生冲突。
模块的主要机制是隐藏信息，相同作用的模式是揭露模块模式(利用立即执行函数)。**js 是函数作用域的**


### Commonjs是如何工作的？

**eval和vm一般不需要使用的，它们会有code注入的风险**
