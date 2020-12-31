---
templateKey: blog-post
id:nodejs-callbacks-control-flows
title: 了解nodejs的回调函数的控制流
slug: /2020/12/30/nodejs-callbacks-control-flow/
date: 2020-12-30T03:48:03.125Z
description:了解nodejs的回调函数的控制流
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - nodejs, design,pattern,callbacks, control flow
---

callback的异步控制流最大的问题在于回调地狱，大量的内嵌很难读和
维护。

异步函数的闭包和就地定义使得编程体验顺利一些，不需要在codebase里
跳来跳去




### Callback Hell
它的问题：
1. 缩进层级太深,冗余的闭包和就地的回调定义，使得code难于阅读和理解
2. 就地定义的回调又会产生大量的变量名重叠
3. closure的会对性能和内存的使用有些影响，还会导致内存泄露(
  任何被活着的闭包引用的上下文都不会被GC回收
)

#### 反模式
``` javascript
asyncFoo(err => {
 asyncBar(err => {
 asyncFooBar(err => {
 //...
 })
 })
})
```

### callback最佳实践和控制流模式

#### callback discipline
写异步的code的时候，最重要的是不要滥用就地函数定义。
回调一般是多和递归以及迭代一起使用。

回调函数的一些原则如下
1. 尽可能早的退出，而不是写完整的ifelse或者内置函数
2. 给回调函数命名，将它们剔除闭包。
3. 模块化code，将code分成更小的可复用的函数。

在请求异步任务的时候，控制权会交还给event loop去执行下一个任务的。
```bash
# parallel
  event Loop                  main              task1            task2 
    |                         |  
    ||-------------------->   ||
    |                         ||---------------> ||
    |                         || <----------------|
    |                         ||---------------------------------> ||
    |                         || <-------------------------------- |
    |<------------------------|
    |                          
    |------------------------------------------->||   
    |                         ||<----------------|                     |<------------------------|
    |                          
    |------------------------------------------------------------>||   
    |                         ||<---------------------------------|
    |<------------------------|                     
    |



```

### 回调函数的sequential模式
``` javascript
const tasks = [];

function iterate(index) {
  if(index === tasks.length){
    return finish();
  }
  const task = tasks[index];
  task(()=> iterate(index + 1))
}

function finish(){}

iterate(0)

```
### 回调函数的parallel模式
``` javascript
const tasks = [];

let completed = 0;
tasks.forEach(task => {
  task(() => {
    if(++completed === tasks.length){
      return finish();
    }
  });
})

function finish(){

}
```
### 回调函数的sequential模式
``` javascript

```































