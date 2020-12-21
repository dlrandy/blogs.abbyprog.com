---
templateKey: blog-post
id:nodejs-intro
title: nodejs 入门
slug: /2020/12/16/nodejs-intro/
date: 2020-12-16T03:48:03.125Z
description: 初步认识nodejs和js
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - nodejs, js
---

js正在向多线程语言过度。Atomics提供了不同线程之间的通信机制；SharedArrayBuffer可以多个线程读写。

当一个函数调用另一个函数的时候，会在当前的stack里加一帧。
js通过事件循环处理并发。
事件循环在碰到新的task的时候，会创建一个新的call stack。

js单线程运行，所以不会同时存在多个调用栈。
cluster允许多个app实例；
worker_threads允许一次运行多个js实例；
child_process用于衍生和管理新的nodejs进程；
这些环境下的js仍然是单线程运行，都是在各种不同的环境。那么不同环境的通信
可能要使用到message passing，通过在各个独立的环境下共享一些数据的序列化描述。
而不是直接共享某个对象。这样就会有死锁或者竞争产生。

worker_threads可以在不同的js实例之间共享内存，可以使用SharedArrayBuffer。或者
使用postMessage。message passing的代价就是数据的序列化和反序列化。

### nodejs overview
``` javascript
j
a
v   userland: app code，npm  modules
a
s
c
r    Core Nodejs APIs
i
p
t

---------------------------------------

c    Nodejs bindings


+    etc. OpenSSL V8  libuv


+    Operating System

```
nodejs 本身是多线程的。
libuv处理系统的抽象和IO，以及V8和第三方模块。相当于调度器。libuv线程池的大小默认是4，最大1024.UV_THREADPOOL_SIZE=num环境变量可以改变。

> nodejs维护需要完成的异步任务，就会保持process运行。nodejs提供了不保活的API。
不保活是.unref(),clearTimeout/Interval等;保活是ref();


### nodejs event loop
浏览器和nodejs的js都实现了event loop，相似的地方是在一个独立的stack里执行异步的task；浏览器的用于强化SPA，nodejs的则是用于server。

> 当有一些事情发生的时候，操作系统会通知nodejs 程序。libuv苏醒，来理解要做什么。可以的话，message冒泡到nodejs APi里的code，然后触发app code里的回调。事件循环允许底层c++的实践跨越界限，运行js code。


### Event loop 阶段
事件循环有不同的阶段。一些阶段不直接处理app code。
每个阶段维护着要执行的callback队列。callback根据app使用它们的方式，
进入到不同的阶段。


- [ ] Poll
  poll相关执行IO相关的callback。app code最可能执行的阶段。主appcode开始运行的时候，就在这个阶段
- [ ] Check
  setImediate的callback执行
- [ ] Close
  EventEmitter的close事件的回调函数执行
- [ ] Timers
  setTimeout和setInterval的callback执行
- [ ] pending
  特殊的系统event运行在这个阶段，net.Socket TCPsocket 抛出ECONNREFUSED错误
> 当一个阶段运行的时候，还会有两个特殊的微任务队列加入到他们。一个是process.nextTick的，另一个是promise。微任务队列的callback优先于阶段的回调。nextTick的回调优先于promise的回调。没有任务的时候，一般会在poll阶段。

### Event Loop tips
1. event loop 一定要一直有事情做
  一个stack里面运行了太多的code，就会阻塞event loop，阻止其他回调执行；
  **修复的办法是将消耗CPU很重的任务，拆分成多个stack(使用setImmediate或者另一个process等，但是不要使用process.nextTick,这样会导致微任务队列不为空，下一个宏任务仍然会被阻塞)**
  ``` javascript
const nt_recursive = () => process.nextTick(nt_recursive); 
nt_recursive(); 
// setInterval will never run 
const si_recursive = () => setImmediate(si_recursive); 
si_recursive(); 
// setInterval will run 
setInterval(() => console.log('hi'), 10);
  ```
2. 不要引入不确定的因素
  如果暴露的方法，会接受一个回调，那么这个回调应该总是异步运行的。
``` javascript
// Antipattern 
function foo(count, callback) { 
  if (count <= 0) { 
    return callback(new TypeError('count > 0')); 
    }
    myAsyncOperation(count, callback);
}
// Right
function foo(count, callback) { 
  if (count <= 0) { 
    return process.nextTick(() => callback(new TypeError('count > 0'))); 
  }
  myAsyncOperation(count, callback); 
}

```

### http OSI 层
``` bash
8 User JSON, gRPC 
7 Application HTTP, WebSocket 
6 Presentation MIME, ASCII, TLS 
5 Session Sockets 
4 Transport TCP, UDP 
3 Network IP, ICMP 
2 Data Link MAC, LLC 
1 Physical Ethernet, IEEE 802.11
```

### http compression
http的response body可以压缩。但是压缩是权衡



### HTTPS / TLS
传输层安全协议(TLS)是用来加密HTTP流量的。不像GZIP压缩，它是会加密
http头部的。TLS也是一个耗CPU的操作，也应该放在外部进程，比如反向代理。

TLS是通过证书生效的。
两种证书：
1. 证书含有公钥
2. 证书含有私钥
> 这两个本来是应该成对的。任何消息都可以使用公钥加密，然后只有拥有私钥的人进行解密。对于http而言，server提供公钥，client使用公钥加密。当用户首次和server通信的时候，它会生成一个大数字，本质上是session的密码，这个大数字是使用公钥加密的，然后发送给server。也就是用来加密TLS session的。Let's encrypt 需要在公网上的server来验证域名的DNS拥有者。所以不适合内部的服务。


### 证书的生成
1. 自签名的证书
  自签名的证书，在浏览器里会有warning，提示信任的问题;
  解决的办法是：
  1. 设置浏览器不验证；
  2. 给客户一个可信任的签名证书；这个证书是通过ca：certContent选项设置的，类似于有了三方的权威机构做了认证
    
  ``` bash
  # 不带CA的
openssl req -nodes -new -x509  -keyout recipe-api/tls/basic-private-key.key  -out shared/tls/basic-certificate.cert
  ```
  
``` bash
  # 带CA的
  # Happens once for the CA( Certificate Authority)
  # 生成CA的私钥
openssl genrsa -des3 -passout pass:123456  -out ca-private-key.key 2048
  # 生成CA的证书
  # 要输入123456
  openssl req -x509 -new -nodes -key ca-private-key.key  -sha256 -days 365 -out shared/tls/ca-certificate.cert


  # Happens for each new certificate
 # 生成服务的私钥
 openssl genrsa -out recipe-api/tls/producer-private-key.key 2048 
# 生成服务的公钥
openssl req -new -key recipe-api/tls/producer-private-key.key  -out recipe-api/tls/producer.csr 
# 生成CA签名了的服务证书
openssl x509 -req -in recipe-api/tls/producer.csr  -CA shared/tls/ca-certificate.cert  -CAkey ca-private-key.key -CAcreateserial  -out shared/tls/producer-certificate.cert -days 365 -sha256

```
** common name的时候，最好填写域名，node开始检验证书了，所以本地开发的时候，可以使用localhost**
2. 使用权威的三方机构提供的证书

### 序列POJOs是危险的
因为重构的时候对象的一些内部属性可能会泄露；较好的方式
是增加一个安全网，例如类里面的toJSON方法，控制json可以展示的内容。
``` javascript
const user1 = { username: 'pojo', email: 'pojo@example.org' };class User {
   constructor(username, email) {
      this.username = username; 
      this.email = email; 
    }
  toJSON() { 
    return { username: this.username, email: this.email, };
  } 
}

const user2 = new User('class', 'class@example.org'); 
// ... 
res.send(user1); // POJO 
res.send(user2); // Class Instance
```
### graphql
它是查询APi的协议。可以精准的返回用户需要的数据；一次请求
可以拿到所有需要的数据。
> graphql不指定要使用的Protocol，http可以，tcp也可以

### graphql schema
描述graphql server可以进行的交互。


### grpc
类REST的模式或者一定程度上的Graphql，都是在试图抽离producer提供的
底层功能，本质上是暴露数据和CRUD操作相关的API。
> 使用HTTP提供的methods不能够很好的描述app的功能

Http提供了有限的动词，RPC可以使用任何的动词
RPC不是创建不同的接口，而是直接以原生的形式暴露方法给网络。
> RPC是选择app里的哪些功能暴露出去，并在暴露的功能和网络接口
之间创建映射。(接受什么样数据，接受谁的数据)

GRPC 通常是运行在H2上的，Graphql暴露一个接口，grac则是根据调用的
方法决定接口。它传输的数据格式是ProtoBuf。

### Protocol Buffers 和 GRPC
Protocol Buffer是对象的二进制序列格式；这种描述带有更少的消息负载，也减少了
每个message的冗余信息，使得网络性能更好。

**为什么说message的field的数字很重要？**
1. field 的名字不会随着message传输
  因为schema是共享的，所以field的名字是冗余的。
2. field的顺序，是用来向后兼容的





> MessagePack是可选的替代格式，层级对象数据的二进制描述
，更多是来替换json的。
Grpc是RPC模式的跨平台实现。

ApacheThrift是ProtoBuf和grpc的替代方案；
JSON RPC是另一外一种。




