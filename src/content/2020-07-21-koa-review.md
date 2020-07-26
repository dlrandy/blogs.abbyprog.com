---
templateKey: blog-post
id: koa-review
title: 读Koa 源码收获
slug: /2020/07/21/koa-source-review/
date: 2020-07-21T03:48:03.125Z
description: 记录一下读koa源码的收获
headerImage: https://i.imgur.com/IONCWVd.jpg
tags:
  - koa, js
---

## 记录

### 关于async 与generator的实现与转换
``` javascript

async function foo(){
  await bar();
}

let foo = (() => {
  var _ref = _asyncToGenerator(function*(){
    yield bar();
  });

  return function foo(){
    return _ref.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn){
  return function(){
    var gen = fn.apply(this, arguments);
    return new Promise(function(resolve, reject){
      function step(key, arg){
        try {
          var info = gen[key](arg);
          var value = info.value;
        }catch(error){
          reject(error);
          return;
        }
        if(info.done){
          resolve(value);
        } else {
          return Promise.resolve(value)
            .then(function(value){
              step('next', value);
            },
            function(err){
              step('throw', err);
            })
        }
      }

      return step('next');
    })
  }
}
```

### koa  vs  express
1. 中间件
  1. express的中间件是基于回调的；koa是基于promise的
  2. 在省略了next调用的情况下，express的request可能会阻塞，
    如果没有设置res.end()的情况下；koa则是下一个中间不会执行，整个request还是会结束的。
  3. koa的中间件是普通函数的时候，注意加上返回值；
  4. koa的错误处理在中间件的顶端；express的错误处理则在中间件的最低端。
2. express适合中小型的；koa适合大型的；
3. koa要自己选择插件；express自带一些插件；
4. koa的性能相对express好一些
5. express是继承并添加了一些对象给原生node的req和res对象；koa则是使用context
替换了原生的noderequest和response。




### lodash之get实现
简单的可写，完全的功能写不出来，难点在于转换路径的时候。
思想就是路径转换成数组，一层一层的找，如果发现不存在了，就是属性值为undefined；
如果找到了最后，索引等于路径长度的时候，切属性值存在，那就是value存在；否则undefined。
https://github.com/lodash/lodash/blob/master/get.js#L13



### koa源码回顾
``` javascript
application.js  [response.js, request.js, context.js]
|
|
new Koa()
|
|
koa.use()
|
|
koa.listen
|
|
koa.callback()
|
|
handleRequest()
|
|
onFinished()             --- request done
|                         ／
|                       ／
compose MiddleWare    ／
|                   ／
|                 ／
respond  --->   ／
```
### koa小问

#### responsejs和requestjs里的this指的是哪个对象？
指的是context对象？

#### context文件做了哪些工作？有什么目的？
他使用了delegator自动设置了一些自身的一些方法，每一个方法
对应着request对象和response对象里的方法。

#### 怎么从代码角度理解洋葱模型？
这个模型主要是依赖koa-compose来实现的。koa的中间件执行返回的
结果都是Promise。也就是每一个next前面都要加上await，如果不是
使用async的函数，要注意返回数据，否则没有数据给上层。
koa-compose主要是dispatch方法，
dispatch(0)
|
|
fn(context, dispatch(n))
也就是A->B->A;


#### 关于request和response和context的几点说明
每次请求到达的时候，koa.context和koa.request以及
koa.response都会作为原型。新的context对象上有
request和response，request和response，是相互引用的。
它们带有的req和res是原生的node对象。








[参考链接](https://hackernoon.com/async-await-generators-promises-51f1a6ceede2)
![FYI](https://i.imgur.com/LalbenT.jpg)




