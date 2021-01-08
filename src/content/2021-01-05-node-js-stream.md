---
templateKey: blog-post
id:nodejs-stream
title: 了解nodejs的stream
slug: /2021/01/05/nodejs-stream/
date: 2021-01-05T03:48:03.125Z
description:了解nodejs的stream
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - nodejs, stream
---

***stream all the things.**
在基于事件的平台上，实时处理IO最高效的方式是一有输入就使用一产生输出就发送。

### buffering VS streaming
对于一个输入操作，buffer是将所有的数据收集到一个buffer里知道操作完成，然后将一整块的数据传给调用者；stream则是有数据到达就处理。

> stream在接收到第一个数据块的时候，就开始启动组装的任务；但是在接受下一个数据块的时候，并不需要等上一个任务完成。另一个组装线是平行运行的。**这里每一个块的到达顺序是要保存的，nodejs已经内部处理了**

**测试的过程中发现，当一个流报错而又没有处理，会阻塞**
> 这么说是因为在server之间传递文件的时候，目标路径并不存在。

### 可组合性
stream是使用pipe方法组合的。pipe允许讲不同的处理单元连接在一起，每个单元执行者不同的功能。之所以是能连接在一起是因为stream有统一的接口。**重要的前提是管道里的下一个stream能够支持上一个stream的数据类型**

### stream的剖析
抽象类型
1. readable
2. writable
3. duplex
4. transform

每一个stream的实例都是Stream抽象类和eventEmitter的实现。

Stream的灵活基于一个事实：处理的不仅是二进制数据，还可以是任何的js值；一般分为两类：
1. Binary mode： 数据块，(buffer或者string等)
2. Object mode：
独立对象的序列

### non-flow  VS flowing
non-flow
是将readable事件的监听器添加到stream，来表明新数据可用， 然后在循环里不断读取内部buffer里的数据，知道buffer为空。
flow
是使用dataevent的监听器从stream里读取数据

### 实现Readable streams
1. 继承实现
  子类必须实现_read(size)方法,可以使用push的方法添加数据
2. new Readable({
  read(size){}
})

> 在继承实现读取流的时候，每次使用push的时候，都有检查一下它的返回值，如果返回的是false，意味着接受的stream达到了内部缓冲的最高警戒线，应该停止添加更多的数据----backpressure。



### Readable streams from iterables


Readable.from默认使用的是ObjectMode。


> 以块的形式加载数据的时候，要使用原生的数据流构建自定义的数据流或者使用Readable.from + lazy Iteratable的形式。

### backPressure
writer写过来的数据操作了reader的读取能力，在不通知writer的情况下就会导致reader的内部缓存积累更多的数据，导致内存的使用问题。那么在write和read的时候，检测操作的返回值来限制writer和reader继续操作。当buffer清空的时候，发射drain事件来恢复写和读的操作。这个机制就是backpressure。


### Duplex Stream
这个是既可读又可写的stream，多用于既是数据源又是数据目标的实体。readableObjectMode,writableObjectMode.既要实现_read又要实现_write.

### transform stream
特殊的Duplex stream专门用于处理数据转换。要实现_transform和_flush()

#### Transform多用于过滤和集合数据

### passThrough stream
特殊的transform，不改变任何的数据块。
多用于Observablity或者实现late piping和lazy stream模式
> 使用PassThrough stream给未来的读到的或者写的数据提供占位符。

### Lazy streams
适用于同时创建大量stream的情况。createReadStream只能创建一个文件流。
lazystream 的npm包允许高效的创建实际stream实例的代理。被代理的实例直到proxy被使用的时候才创建。

### pipe连接stream
pipe允许多个stream串联，每次都会返回pipe的第一个参数的stream，自动的调用read write，不需要控制backpressure。
> 对于pipe的错误处理只能是一个stream一个stream的被监听error，好点的办法可能是使用同一个错误函数处理，并在里面清除stream。

``` javascript
stream1.pipe(stream2).on('error',()=>{/*
  stream2的error handle
*/})


// 内存泄露问题
stream1
 .on('error', () => {})
 .pipe(stream2)
 .on('error', () => {})

function handleError (err) {
 console.error(err)
 stream1.destroy()
 stream2.destroy()
}
stream1
 .on('error', handleError)
 .pipe(stream2)
 .on('error', handleError)

```

### pipeline 更好的错误处理方式
pipeline(stream1, stream2, stream3,..., cb)
对于每个stream会自动注册适当的error和close监听器。


### 顺序执行
transform的回调函数保证这chunk的正确顺序。

> 使用stream或者stream的组合可以简单顺序的迭代一组异步任务。

### 无序的并行
Object stream不需要注意顺序；binary stream则是重视数据处理顺序。

### 有序的并行
需要时候用buffer去重新排序chunks，parallel-transform
> 对于顺序并行的模式，要意识到慢的任务会阻塞pipeline或者不确定的增长内存。一个耗时的任务，依赖于实现的模式，要么是包含挂起任务的buffer的无限增长或者整个处理过程指导该任务完成。第一个模式多用于性能；第二个而是优先于可预见内存的使用。parallel-transform属于第二种情况。

### Piping 模式
nodejs的stream可以根据不同的模式连接在一起。
一般会有：
1. 合并多个不同的stream为一个stream
2. 将一个stream流分开到不同的pipes
3. 基于条件重定向stream。

### combine stream
stream提供了一个简单的基础结构来模块化和复用我们的code。
但是怎么模块化和复用一个完整的管线？
> 对于合并的stream的两点启示：
> 1. 写入到合并流的时候，实际上是写到了管线的第一个stream；
> 2. 从合并流读取的时候，实际上是读取的管线的最后一个流
> 3. 合并流必须捕获和冒泡管线内部任何stream发射的错误。
合并流通常是Duplex的stream，通过将第一个steam连接到自身的Writable Side以及将最后一个stream连接到自身的Readable Side。一般的Duplex库会有duplexer2和duplexify。
