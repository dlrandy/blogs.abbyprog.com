---
templateKey: blog-post
id:typescript-intro
title: typescript的选择与思考
slug: /2020/12/23/ts-thinking/
date: 2020-12-23T03:48:03.125Z
description: 为什么使用typescript？
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - typescript, solid, design,pattern
---


语言会变。但是软件设计原则和类型会提升code质量和可读性的事实不会变。

### typescript的目标
1. 给js开发者提供可选的类型系统
  因为js系统越来越复杂，想通过类型系统管理复杂性。
2. 提供js开发者使用未来的js的特性

typescript是JavaScript的超级；js里有效的在ts里都可以。


### typescript里四种类型
1. 显示类型
2. 隐式类型
3. 结构化类型
 - Nominal 类型
   通常使用抽象(接口和类)来进行类型兼容
    1. 类型的显示声明
    2. 类型是子类型 
 - Duck 类型
  类型的兼容和等价是由类型的实际结构决定的。
4. 环境类型(主要针对第三方的js库)
   可以理解是declaration，也就是引入定义文件。

### 升级到typescript
在tsconfig.json里设置allowJs为true就可以，一点点的升级ts了。最好先不要将js后缀改为ts否则编译不通过。

### 扩展性
软件开发领域的扩展性，一般有：
1. 性能的扩展性(wasm？？)
2. 生产力的扩展性(ts处理是这一阶段)

> - 启用编译器或者lint工具来在编译时捕获bugs,typos和其他错误
> - 测试是最好的文档，类型不适合写测试，但是可以减少表面上的bug
> - 测试能使重构更快更安全。测试不在，类型也可以捕获语法的不正确


### 困难软件问题的分类
1. 性能系统问题
2. 嵌入式系统问题
3. 复杂domain问题(这里最好就是用类型的语言了)
  这里一般是扩展codebase的问题，同时要保持codebase的可维护和灵活，同时增加新的特性，不会破坏已有的特性(可靠性)。
  这个问题的工程化挑战是：
  1. 对domain概念进行建模，实际解决domain的问题，使用每个人都可以理解的术语
  2. 能够逻辑上将整体里的不同部分拆分成小的app
  3. 将不同的app部分分给不同的team来维护
  4. 整合业务逻辑，在不同的微服务之间同步数据
  5. 不要因为编写了太多的code而迷失
  6. 不要降低生产力和滑落到不得不破坏已有的结构才能添加新的特性的时候
  7. 写能够正确表达domain model和语言的code，使得新的人员简单的看下code就能够了解domain

此外一些影响ts使用的因素：
1. code size
  一般来说，大的codebase的domain都很复杂。当code达到一定的size的时候，很难去追踪已有的code，就会容易重复实现已有的实现。对于那些简单的小的项目，或者知道最终会被丢弃的项目，不推荐使用
2.  Production software Vs. pet projects
3. 缺失单元测试
  最好使用ts
4. 创业公司
  那就要选择有生产效率的语言了，而不是去考虑什么扩展和学习成本高的语言  
5.  团队体积
  如果特别大则考虑使用偏执的框架，比如前段Angular, 后端是Typescript；因为它们限制了解决问题的几个方式。ts也会节省沟通成本。
6. 沟通patterns和实现设计原则
  类型方便描述程序目的和设计原则
7. 小的team 和代码风格
  小team易于管理编码风格和沟通，再加上验证工具，以及hooks等就可以保证好的code。不需要ts。
  但是随着code增长和team成员的增长，会需要typescript了

### 什么时候使用ts
- 适合复杂的domain问题(也就是管理复杂domain的复杂性)
- 复杂的domain以DDD来实现的话，ts更为你合适
- codebase在指数级变大或者长久存在的时候
- team人员较多的时候

### 为什么使用ts(使得下面的操作都更容易)
- 捕获错误，表达期望的类型
- 实现设计模式和经典的OOP原则
- 写SOLID的code
- 在大的team里工作容易，因为大的team里需要沟通程序目的和限制不好的编程行为
- 因为偏执性，只有一种特定的方式完成一种任务。这也是为什么Angular在企业社区流行的原因，而react则有一百种方式完成一种特性。


### 什么时候使用js
- 要解决的问题不是复杂的domain问题
- 如果是复杂的domain问题，同事都能够使用js的原型OOP风格进行领域建模以及知道在没有接口和抽象类的情况下写SOLID code
- code size相对较小
- 只有你一个在处理项目
- 身在创业公司而且正在寻找产品市场契合度和吸引力，这些是要比工程化更重要的

### readonly 修饰符
这种readonly属性一定要在声明或者构造器里使用



### type 验证
as

### type 关键字
多于一些类型操作，或者简单类型

### type alias
主要是为了使code类型更有表达性和目的性

### Union Types

### Intersection types

### enum

### any

### void
表示没有返回值

### Inline & literaltype
``` typescript
type literalType = 'y' | 'x';
const GenreType: { [index: number]: string } = { 1: "Metal", 2: "Rap", 3: "Pop"
}
```

### type guards
将对象类型缩小到条件块里
1. typeof 
2. instanceof
3. in