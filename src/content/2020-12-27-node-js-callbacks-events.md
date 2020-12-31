---
templateKey: blog-post
id:nodejs-callbacks-events
title: 了解nodejs的回调函数和事件
slug: /2020/12/27/nodejs-callbacks-events/
date: 2020-12-27T03:48:03.125Z
description:了解nodejs的回调函数和事件
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - nodejs, design,pattern,callbacks, events
---

同步的code，易于读，理解和测试
异步的code，一旦启动，就会在后台运行。一旦操作完成，使用操作返回的结果继续执行程序流。
callback是nodejs里最基础的机制用于通知异步操作的完成。
> 没有回调就没有promise，也不会有async/await，也不会有streams和事件

### how callback works？
callback是Reactor模式的处理句柄的实体化。callback是那些传送操作完成结果的函数，恰恰也是异步操作最需要的。

### continuation-passing style(CPS)
函数编程领域，将回调函数传递结果的方式叫做CPS。而cps又为同步和异步两种。
> 同步函数会一直阻塞到它的操作完成。异步操作会立即返回，它的结果会在下一个事件循环传递给处理句柄。

### 同步还是异步？
不管是同步还是异步，最终要避免的是不一致以及同步和异步的困惑。也就是说函数内部的不同分支的结果必须要么同步的要么是异步的。
**总是使用direct style来处理纯同步函数**
> 记住将API从CPS改成direct style，或者从异步改成同步，反之亦然，这些都需要所有的code使用同一个风格。
js一般是不适用同步的；1.特定功能同步的APi可能没有2.同步APi会阻塞事件循环和阻塞并发。

**只在不影响app处理并发的异步请求的时候，使用阻塞式API**


### 使用deferred执行来保证异步性
一般讲callback使用process.nextTick()或者使用setImmediate，timer等进行包装处理。


### Nodejs 回调的约定
1. 回调函数总是在参数的最后(即便是有可选参数)
2. 回调函数的任何的错误总是出现在参数的第一位
3. 传递错误
  同步传递错误，一般是使用throw；异步的话一般是将错误直接传递给回调函数。
4. 未捕获的异常
  nodejs里有一个无法恢复的状态，应用程序会因此非0退出。
  **一旦错误抛到了event loop，app就会终止，终止之前会发射uncaughtException，用于进行清除或者日志工作**
  >uncaughtException会留给应用程序一种不保证一致的状态，所以捕获了之后一般也是直接退出或者重启


### Observer模式
Observer和Reactor模式以及回调是Nodejs异步世界的绝对需要。
> Observer 模式定义一个subject，当有状态变化产生时，通知一系列的观察者。和callback的不同在于callback只处理一个监听器。

### EventEmitter
events原生模块里提供的。EventEmitter不会抛出错误只会发射一个error事件。要制作一个observable的对象，只需要继承eventEmitter，实例化即可。


### EventEmitter和内存泄露
对于那些不再需要的监听器，注意去取消订阅。这样可以释放那些监听器作用域的对象使用的内存，从而阻止内存的泄露。

### 同步事件 和异步事件
他们之间的不同在于监听器的注册方式。异步发射事件，我们可以在触发事件的任务之后添加监听器，监听器仍然会生效；同步的就不可以。**所以不要发射同一个事件类型，使用混合的事件，容易产生Zalgo**。实际上任何的同步事件是不需要使用EventEmitter的。

### Events VS  callback
什么时候使用一个而不使用另一个？
1. callback的局限性在不好支持不同的事件类型
2. EventEmitter适合一个事件多次发生的情况
3. 使用回调的APi只能通知一个callback；EventListener可以多个。

### 结合callback和Events
也就是使用传统的回调异步的传递结果。