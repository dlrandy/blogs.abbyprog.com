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



