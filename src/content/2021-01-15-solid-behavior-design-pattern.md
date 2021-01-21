---
templateKey: blog-post
id:solid-design-principles
title: solid design principles
slug: /2021/01/15/solid-behavior-design-pattern/
date: 2021-01-15T03:48:03.125Z
description: 学习solid design patterns
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js, solid, design pattern, structural
---

行为设计模式关注着组件的行为。
这里学习如何去组合对象；如何定义对象之间的通信方式，以至于最终的结构易于扩展，模块化，可复用和可适配。

### 行为设计模式解决的常见问题
1. 如何运行时改变算法的某些部分
2. 如何基于状态改变对象的行为
3. 如何不需要了解背部实现的情况下 迭代集合

**中间件模式仿效的是责任链模式**


### strategy 模式
改变组件的某些部分来满足特殊的需要。
> 使得对象(context)支持逻辑的变化，通过将变化的部分抽离成独立的可互换的对象。context实现一组算法的通用逻辑，而策略实现可变化的部分，允许context根据不同的情况来调整行为，也就是使用不同的策略。比如一些多个ifelse的情况。**所有策略实现的是context期望的一组接口**

**策略模式不仅有助于解决分离给定问题的关注，还能够灵活的适配同一个问题的不同变种**


### State 模式
基于状态改变组件的行为
> 是特殊的策略模式。只不过是基于context的状态改变策略。

**strategy VS  state**
策略模式一旦选定策略，在context的整个生命周期中不能改变；而状态则是动态的，在context的生命周期中可以改变的，允许根据内部状态改变行为。
> State模式下，策略是动态的，可以在context的生命周期里变化的, 因此允许根据内部状态的变化来改变行为

**state 过渡**
状态的过渡是由(context,client code, state 对象自身)初始化和控制的。state自身控制的话通常会更灵活和解耦，因为context不必知道所有的状态和状态之间的过渡方式。

### template 模式
复用组件的结构来定义新的组件
使用抽象类定义组件的骨架，留下一些步骤未实现。子类通过实现这些缺失的部分，来完成新的组件功能。

**Template VS State**
主要不同在于结构和实现上。

相同点：
  1. 复用其他部分的同时允许改变组件变化的部分 
不同点：
  1. strategy 模式允许在运行时动态的改变；模板则是在实体类创建的时候，就确定好模板组件
  

### Iterator 模式
基于通用接口迭代集合
定义一个通用的接口或者协议来迭代容器里的元素。迭代的算法不依赖数据的实际结构。
这个模式将遍历算法的实现和遍历操作的目标进行了解耦。

> 实现迭代器模式的起点就是迭代器协议--定义产生值序列的接口。
#### iterator
实现了next方法的对象，next方法返回的对象是Iterator result包含两个属性{done, value}。当然iterator result也可以有别的属性。iterator除了有next方法之外，还可以有throw 和return方法。


#### iterable 协议
定义了对象返回iterator的标准方式。而返回iterator的对象叫做iterable。iterable通常是大量元素的容器。在JavaScript里iterable是实现了@@iterator方法的对象，也就是通过Symbol.iterator属性访问到的函数。

#### generator 函数
generator函数返回的对象既是iterator又是iterable。

#### Async iterator
async Iterator本质是一个stream 构件，因为他们可以用来一块一块的处理异步数据源。stream.Readable确实也实现了@@asyncIteraotr的方法。

#### stream VS async iteraotrs
1. streams是push的，意味着数据被stream推入内部buffer，使用的时候从buffer里取。Async Iterators默认是pull的，意味着数据只在用户需要的时候产生。
2. stream更适合处理二进制数据，因为它们原生的提供内部buffering和backpressure。
3. streams可以使用streamline，pipe组合；async Iterator并没有标准的组合方式。

> EventEmitter是可以被迭代的；events.on(emitter, eventname)这个工具函数也是使用的async iterable.


### middleware 模式
定义处理步骤的模块连。
通常的意义上来说，定义的是任何的软件层来作为底层服务和app之间的粘合剂。

#### Express的中间件
通常是一些service(函数)，以管线的形式组织，并且负责处理进来的http请求和相关的response。

> 中间件是拦截过滤模式和责任链模式的化身，可以理解为处理管线。一组处理单元，过滤器和处理句柄，以函数的方式连接起来形成一个异步序列，来对数据进行preprocessing和postprocessing。

#### middleware 模式的好处
灵活。中间件模式易于得到插件架构，可以方便的使用新的filter和handler进行扩展系统。

#### middleware 模式的实现细节
模式的核心组件是middleware manager，负责组织和执行中间件函数
- 通常新的中间件注册使用use函数，一般是加在pipeline的最后，都不是严格的原则
- 当接收到要处理的新数据的时候，注册的中间件是以异步的顺序执行流调用。每一个中间件只接受上一个的中间件的结果作为输入
- 每个中间件都可以决定是否停止进一步的数据处理。通常是需要调用特殊的函数，或者是不调用回调函数或者冒泡错误。错误的情况通常会触发另一个专门处理错误的中间件执行
- 一般是引用额外的属性和函数来强化接受来的数据
- 保持数据的immutability和经常返回处理结果的拷贝



### command 模式
物化执行事物的信息，允许信息传输，存储和处理

command是包含了所有稍后执行动作需要的所有信息。命令模式中，我们不直接调用某个函数，而是创建一个对象来描述执行调用的目的。然后由另一个组件负责物化这个目的，并转换成实际的action。

#### command的组成
1. command
  封装了调用函数需要的所有信息的一个对象
2. Client
  创建command，并把它提供给Invoker
3. Invoker
  负责在target上执行command的组件
4. target
  被调用的主体。

#### command的应用场景
1. command可以安排在稍后执行
2. command容易序列化通过网络传输
3. command模式更容易记录系统上所有操作的执行记录
4. command是数据同步和冲突解决的算法的一部分
5. 计划执行的command可以被取消，回退，利于app的状态回退
6. 几个命令可以分组，易于创建原子事务
7. 不同的转换可以由一组命令执行，这种在实时协作软件里常用

#### Task 模式是命令模式的一种实现
``` javascript
function createTask(task, ...args){

  return () => {
    target(...args);
  }

}
//=============
const task = target.bind(null, ...args)
```
