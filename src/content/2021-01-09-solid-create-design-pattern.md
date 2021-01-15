---
templateKey: blog-post
id:solid-design-principles
title: solid design principles
slug: /2021/01/09/solid-create-design-pattern/
date: 2021-01-09T03:48:03.125Z
description: 学习solid design patterns
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js, solid, design pattern, create
---

设计模式是反复发生的问题的可复用方案

create design pattern主要是解决创建对象相关的问题。

> 工厂模式将对象的创建封装在函数里；revealing constructor只在对象创建的时候，暴露私有对象的属性和方法；Builder模式简化了复杂对象的创建的过程；单例和依赖注入有助于写module。

**js里建议使用通用的直觉的图示而不是uml来描述pattern，因为一些模式不但可以基于class，还会基于对象或者函数**


### Factory
主要是将对象的创建从特殊的实现中解耦出来。

#### 应用场景
1. 创建对象的类是在运行时确定的（增加一些额外的初始化步骤或者基于条件返回不同的克星）
2. 相比类，工厂是一个函数，暴露出的信息更少，更易理解
3. 通过闭包强化封装




> js中，函数范式优先于OO设计模式，函数范式更为简单，可用和small surface area.

#### 使用new创建对象有什么不好？
new关键字会将code和特定的对象类型进行绑定。而工厂则会提供更多的灵活性。

#### 强化封装
封装指的是控制组件内部的一些细节的访问，通过阻止外部code直接处理组件的内部细节。外部只能通过组件的公共接口处理组件的细节。
**面向对象的重要设计原则：继承 抽象 封装 多态**

##### 封装的方式
1. 使用私有class fileds, #fieldname
2. 使用weakmap隐藏细节信息，一般使用this作为键值
3. 使用symbol，但是可以通过Reflect.ownKeys和Object.getOwnPropertySymbols获取到私有键值
4. 使用约定'_'
5. 使用工厂或者闭包

### Builder
通过提供流畅的接口，简化复杂对象的创建，一步一步的构建对象。改善了可读性和开发者体验。

#### 适用场景
1. 类的参数比较多的情况，或者是参数比较复杂
 > 对参数较多的时候，一般会使用对象容纳参数，但是不好的地方在于要想了解实际的参数，就只能去看class的文档或者是class的code。同时也没有想干类的创建协议。