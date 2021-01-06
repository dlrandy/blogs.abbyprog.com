---
templateKey: blog-post
id:nodejs-promises-control-flows
title: 了解nodejs的promises的控制流
slug: /2021/01/03/nodejs-promises-control-flow/
date: 2021-01-03T03:48:03.125Z
description:了解nodejs的回调函数的控制流
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - nodejs, design,pattern,promise, control flow
---

Promise是一个体现异步操作最终结果的对象。

> 鸭子类型：基于队形的外部行为而不是实际的类型来认知（类型化）对象


### promisification
可以根据回调函数的特点，将基于回调的函数转化成返回promise的函数。
回调函数的特点：
1. 回调函数总是作为函数的最后一个参数
2. error总是作为回调函数的第一个参数传给回调函数
3. 函数的返回值将在error之后传给回调函数

``` javascript
function promisy(apiBasedOnCallback){
  return function promisified(...args){
    return new Promise((resolve, reject)=>{
      const newArgs = [
        ...args,
        function(err, result){
          if(err){
            return reject(err);
          }
          resolve(result);
        }
      ];

      apiBaedOnCallback(...newArgs)
    });
  }

}

```

在构建无线的promise 链的时候，请多次检查可能会内存泄露的情况。
一般解决的办法是不要返回promise。二是因为一的方法切断了和外面的联系，所以二的方法是在一的基础上进行一个promise的封装。三是使用async/await+循环。

**注意async await和那些回调循环的一些情况，回调的循环不能意识到await的**

