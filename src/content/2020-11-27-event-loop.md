---
templateKey: blog-post
id: event-loop
title: 了解event loop和microtask以及macrotask
slug: /2020/11/27/css-module/
date: 2020-11-27T03:48:03.125Z
description: 了解 js的event loop和microtask以及macrotask
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js, event loop, microtask, macrotask
---
### 先看两个code
``` javascript
setTimeout(() => {
    console.log(1);
}, 0);
var a = new Promise((s, r)=>{
console.log(2);
s(3)
});
a.then(s=>{
    console.log(s);
    return 4;
}).then(s=>{
    console.log(s);
    return 5;
});

console.log('sssss');
// 2  sssss 3  4 1
//-------------------------------------------------

setTimeout(() => {
    console.log(1);
}, 0);
var a = new Promise((s, r)=>{
console.log(2);
s(3)
});
a.then(s=>{
    console.log(s);
    return fetch('https://jsonplaceholder.typicode.com/todos/1')
    .then(response => response.json());
}).then(s=>{
    console.log(s);
    return 5;
});

console.log('sssss');
// 2  sssss 3 undefined  1 {data}
```
### event loop
```js
____________________________________|
|                                 '''''
|                                 script
|                                 microtasks
|event loop                       render
|                                   |
|                                 mousemove
|                                 microtasks
|                                 render
|                                   |
|_________________________________settimeout

```
需要注意的点
- 在引擎执行任务的时候，渲染是不会发生的。DOM改变的重绘只会发生在task完成之后。
- 如果任务花费太长的时间，浏览器将不能做其他的task，会有页面不响应的情况发生。

###应用场景
- 重型(macro)任务拆分
将一个大型的macrotask分成多个macrotask执行，以至于不会影响到其他的macrotask。当然也可以使用worker来完成。
具体参考下面的例子。
- 进度条指示
拆解重型任务的好处是可以展示进度条
- 在事件之后做一些事情
比如事件句柄只在事件冒泡之后以及所有级别都处理过之后。

``` javascript
let i = 0;
let start = Date.now();
function count() {
  // do a heavy job
  for (let j = 0; j < 1e9; j++) {
    i++;
  }
  alert("Done in " + (Date.now() - start) + 'ms');
}
count();
//-----------------------------------------


let i = 0;
let start = Date.now();
function count() {
  do{
    i++
  } while(i % 1e6 != 0);
  
  if(i >= 1e9){
alert("Done in " + (Date.now() - start) + 'ms');
  } else{
    setTimeout(count,100)
  }

  
}
count();
// ------------------------------------------
let i = 0;
let start = Date.now();
function count(){
  if(i < 1e9 - 1e6){
    setTimeout(count);
  }
  do{
    i++;
  } while(i % 1e6 !== 0);

  if(i === 1e9){
    console.log(`jobs id ${Date.now() - start} ms`);
  }
}
 count();


//-------------------------
(function main() {
  function count(jobs) {
    let i = 0;
    let start = Date.now();
    function group() {
      //  do a heavy job
      // for (let j = 0; j < 100 && i <= jobs; j++) {
      //   i++;
      // }
      do {
        i++;
      } while (i % 100 !== 0 && i < jobs);

      if (i >= jobs) {
        console.log("jobs Done in " + (Date.now() - start) + "ms");
      } else {
        setTimeout(() => {
          console.log(i);
          group();
        }, 100);
      }
    }
    group();
  }

  count(500);
})();

```
> 浏览器内置的setTimeout最小的延迟是4ms，即便你是设置为0，所以安排的越早，执行的越快。
### 判断计数器的办法
 
 1. 计数比较
 2. 模上峰值，直到为0

microtasks和macrotasks
微任务在每个宏任务执行后，立即执行，引擎执行微任务队列里的所有任务，优先于其他的宏任务和渲染等。


### 页面交互触发事件和DOM自行触发事件是有区别的
页面上的交互，microtask会在事件监听函数之间执行；但是DOM上的click会引起事件同步dispatch，所以调用click的script仍然在stack里，这样保证了microtask不会打破js的执行。

**microtask只能在task结束以及jsstack清空之后才执行，实际上是jsstack为空的时候执行**

**事件冒泡的优先级高级下一个task**

### 微任务和任务的总结

- task是顺序执行的，render在任务之间渲染
- 微任务顺序执行，且只在
  1. 在每个回调之后，只要没有js在执行(没有jsstack存在)
  2. 在每个任务之后


**对于同一个dom上的mutationObserver触发的事件，微任务队列里不能有两个同样的任务**


### 内嵌settimeout 和setInterval
 
 1. 内置的更为灵活，可以设置不同的时间间隔；
 2. setInterval的调用的真正是时间是小于code指定的
 3. settimeout可以保证固定延迟
 4. 

 **传递给setTimeout/setInterval的函数，会阻止被GC，知道scheduler调用它。它的这个函数还以引用外部的词法作用域，所以它存在，外部的变量就会存在**






### api
```js
queueMicrotask
```

https://javascript.info/event-loop
https://jakearchibald.com/2015/tasks-microtasks-queues-and-schedules/





