---
templateKey: blog-post
id: mastering func
title: 掌握函数基础
slug: /2020/08/31/mastering-func/
date: 2020-08-31T03:48:03.125Z
description: javascript 函数回顾
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - fp, typescript, function
---

typescript里函数的类型，可以从函数值来推导出来；
所以函数变量不需要添加冗余的类型声明。


typescript的函数，可以根据return推导出函数的返回类型

在类里箭头函数改变了this工作的方式


trailing commas是js和ts 的最佳实践

可选参数必须放在必填函数的后面；
可选参数使用的时候，需要校验；所以有了
默认参数。

因为undefined有可能被用来作为变量名，
所以判断undefined的时候使用void 0；


arguments暴露了标准数组对象的一些方法，但不是
所有。

函数或者方法，重载是使用同样的名字和不同数量的参数或者不同的类型创建多个函数的能力。
在typescript里，重载函数需要先指定所有的函数签名，最后跟上实现的签名；
所有的函数签名应该兼容(指的是返回值类型)。

> 使用特殊的签名可以创建带有同名和同样数量的参数的函数，但是可以由不同类型的返回值。为了创建特殊的签名，
必须使用一个字符串来指定函数参数的类型。字符串字面量用来识别哪个重载函数在被调用


签名的实现必须兼容所有的重载签名，总是在列表的最后，接收any或者联合类型作为它的参数类型

写重载声明的时候，非特殊签名的声明放在最后



理解typescript的scope运行的原理，有助于理解变量的生命周期

lexical scoping
是编程语言使用程序源码的结构来决定哪些变量可以引用

dynamic scoping
使用的是程序栈的运行时state来决定哪些变量可以引用

词法作用域相对较容易理解一些




hoisting
在运行时，函数执行之前，所有的变量声明都会被移动到函数的顶端

let关键字运行将变量的作用设置到block内。

一个immutable的变量，意味着它是不能被修改的


立即执行函数是使用函数作用域创建词法作用域的一种模式。可以避免其他blocks的变量提升或者阻止污染全局作用域；也可以实现运行时的私有变量；

闭包是引用独立变量的函数。也就是定义在闭包里的函数，可以记住被创建时的context(作用域里的所有变量)

像是classes，module等组件被其他的组件使用的时候，很少担心实现运行时的私有属性。

使用模板字符串创建的特殊函数叫做tag函数，它主要是用来
修改标准模板字符串的行为的。
好处就是可以创建自定义的模板字符串处理器。

tag函数的参数，第一个是包含模板字符串里的静态字面量
接下来的参数就是依次的变量值

箭头函数式是函数表达式的简洁语法，词法上绑定了this的值，也就是可以在不修改this值的情况下
添加函数


待验证
定义一个匿名函数，this会改变指向匿名函数

回调地狱会导致维护问题：
1. code难于理解
2.难于维护（重构复用）
3.异常处理更困难


一旦Promise完成或者rejected，它的状态就不会在变了

“he try…catch statement is not needed for a Promise function because, when an error is thrown within a promise, the promise will automatically be rejected.”

Promise函数不需要try..catch，因为Promise内部发生错误的时候，Promise自动被rejected

promise的异步控制流：
Concurrent: 任务并行执行  
Race: 任务并行执行，只返回最快的结果
Series: 一组任务顺序执行，但是上一个任务不会给下一个任务传递参数
Waterfall: 一组任务顺序执行，上一个任务给下一个任务传递参数
Composite: 上述控制流的各种组合

typescript的新版本会引入一些新的特性来检测新的errors。

generator代表是一个值序列。generator的接口是iterator

异步的iterator每次调用next方法都会返回一个Promise

可以使用yield*表达式将一个generator代理到另外一个generator；
也可以用来将将迭代代理到iterables，比如数组。

event loop和this
JavaScript的运行时监督JavaScript代码的执行

有一些的变量存在特定环境的运行时上面；

js的运行时有很多种比如常见的各种浏览器，桌面，nodejs，jvm等。

js有一个并发模型是基于event loop的，

js 的runtime的一些概念：
Heap，Stack，Queue，Frame
Frame是stack的一个顺序工作单元；也就是一个函数块。
就是说每一个函数执行的时候，都会有一个新的frame进入stack。

stack是一个后进先出的对象的集合。

queue包含着的是待处理的消息列表，只会在stack清空的时候，执行；
这里的消息一般是用户或者application的事件。

heap包含的是变量和正被使用的对象以及一些未被移除的frame


因为js的单线程和event loop，js是没有真正的并发的

event loop
它遵循这运行到完的规则，但是yield可以解决这个问题

web worker是以另一个线程后台运行，有自己的queue heap stack

event loop的好处执行的顺序可预见；不好的是如果一个消息(event)
占用了太长的时间，会导致程序无响应。所以最佳实践就是消息使用的
时间要尽可能的短。

nodejs的runtime是非阻塞IO的模型和单线程的事件循环模型的结合。
也就是app在等待IO操作的时候，仍能够处理其他事件。

JavaScript的this是由函数的调用方式决定的

在global环境下，this指向global对象

函数环境下的this
取决于函数的调用方式，非严格模式下指向global否则是undefined

原型继承模型里，对象继承对象。

可以在运行时给实例对象添加属性和方法；而且这些属性和方法不用是class里声明的
``` javascript
function (d, b) {
  for(var p in b){
    if(b.hasOwnProperty(p)){
      d[p] = b[p];
    }
  }

  function __(){
    this.constructor = d;
  }
  __.prototype = b.prototype;
  d.prototype = new __();

}
```

访问对象原型的三种方法
1. Person.prototype
2. Object.getPrototypeOf(person)
3. person.__proto__

闭包是函数引用自由独立变量的函数。自由独立的变量
持久在创建时的词法作用域里


静态变量可以被类的多个实例共享



![frames](/static/assets/js——runtime@2x.png 'frame')
