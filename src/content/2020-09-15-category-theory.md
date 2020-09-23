---
templateKey: blog-post
id: 分类理论
title: 初识分类理论
slug: /2020/09/15/category-theory/
date: 2020-09-15T03:48:03.125Z
description: 了解分类理论和代数数据类型
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - fp, typescript, category, algebraic
---

FP的语言和设计模式受不同的数学领域的影响。分类理论
就是众多的影响之一，它类似集合论。定义了代数类型的
理论。

### Functors
特点是
1.持有一个value
2.实现一个map函数

### applicative
是实现了of的Functor，又因为它是apply的类型
所以可选的实现ap方法

### MayBe
是functor和applicative，以为着包含value
和map，还有静态的of以及ap方法。但是value
是可选的。


### Either
是Just和Nothing的联合类型
nothing代表着值的缺失；

### Monad
是一个functor。但是也实现了applicative和Chain的规范

chain的规范有join和chain的方法接口

### immutability
是一种不会再改变value的结构。typescript里使用class和readonly
来实现。有助于实现纯函数和减少side effects。
但是容易产生冗余的code

### optics
解决了immutable的冗余code问题。
它的本质就是对象的属性的get和set的一种方式。
optics有两组： lenses和prisms
lenses用于使用product类型，例如对象元组；
prisms适用于sum类型，例如联合类型；
### lenses
一组函数获取和设置对象的值。
lenses的特点是可以组合。


### Prims
和lenses相似，但是是设置和获取对象上的可选属性的
### Lazy evaluation
推迟表达式的执行到value真正需要的时候执行
实现的方式：
1. 可以使用proxy
2. generator和iterable



