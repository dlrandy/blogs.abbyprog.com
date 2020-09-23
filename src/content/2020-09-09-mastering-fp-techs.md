---
templateKey: blog-post
id: mastering fp techs
title: 掌握函数编程技术
slug: /2020/09/09/mastering-fp-techs/
date: 2020-09-09T03:48:03.125Z
description: 函数编程基础技术
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - fp, typescript, function
---
“Composition
将多个函数合并成一个复杂的函数. 多适合单参数的函数
``` typescript
const compose = <T1, T2, T3>(f: (x: T2) => T3, 
    g: (x: T1) => T2) =>(x:T1)=>f(g(x))
```

Partial application
在不同的时间上，传递给函数需要的参数

Currying
允许部分调用一个函数，一次调用一个参数这样
Pipes
是一个函数或者操作符允许将一个函数的输出作为另一个函数的输入
Point-free style
函数声明不声明要处理的参数
Recursion
函数调用自身。注意每一个递归调用都会产生一个frame

Pattern matching
将value匹配到一些patterns上来选择一个code的分支
typescript允许使用字面量类型和控制流分析；来实现模式匹配

