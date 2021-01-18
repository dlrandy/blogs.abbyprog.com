---
templateKey: blog-post
id:solid-design-principles
title: solid design principles
slug: /2021/01/11/solid-structural-design-pattern/
date: 2021-01-11T03:48:03.125Z
description: 学习solid design patterns
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js, solid, design pattern, structural
---

结构化设计模式关注于在不同的实体之间提供实现关联的方式


- proxy
 允许控制另一个对象的访问
- Decorator
  动态的强化已有对象的行为
- adaptor
  使用不同的接口访问对象的功能

  ### Proxy
  proxy是一个对象，控制对subject的访问。proxy和subject持有同样的接口，拦截所有或者一些对subject的操作：将没操作转发给subject，使用额外的预处理或者后处理来强化操作行为。

#### 使用的场景
1. 数据验证
  转发到subject之前，验证数据是否合法
2. 安全性检查
  检查是否有执行某个操作的权限
3. 缓存
  proxy维持一个内部的cache，以致于被代理的操作执行在没有缓存的subject上。
4. 懒初始化
  创建对象耗费资源的情况下，将创建推迟到在真正需要的时候。
5. 日志
  拦截方法调用和相关的参数，在执行时候做记录
6. 远程对象 
  proxy获取远程对象，使得像本地对象一样


#### 实现代理的方式
1. 对象组合
  出于扩展或者使用功能的目的，将一个对象和另一个对象组合在一起。在Proxy的情况下，subject的引用以实例变量或者闭包变量存储在proxy里。
2. 对象强化(猴子补丁)
  直接修改subject，一般是替换被代理的实现。适用于只代理几个方法的简单情况以及在可控的环境下或者私有作用域下。
3. es5的proxy
  Proxy是一个强大的功能，但是不能够polyfilled，因为它的traps只在运行级别实现的，不能再js里改写。

> 组合是最简单和安全的创建proxy方式，不会改动subject，不会改变最原始的行为；强化可能不总是完美的，因为修改了subject。lazy 初始化不需要使用composition。


### 使用Proxy改变Observer模式
当subject的状态发生变话的时候，通知一个或者多个observers.


### Decorator
动态的强化已有对象的行为。与Proxy 模式不同的是，proxy 会强化或者修改已有的行为，而装饰器则是添加新功能来强化。

#### 实现Decorator的技术
1. 组合
  被装饰的组件被一个新的对象包装。一般只需要添加新的方法，同时将已有方法代理到原始的组件。
2. 强化(猴子补丁)
  只需要将新的方法直接加到被装饰的对象上
3. proxy
  proxy内部返回一个新方法

### 适配器
允许使用不同的接口访问对象的功能。也就是接受一个对象的接口使它和用户期望使用的接口相兼容。
