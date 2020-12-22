---
templateKey: blog-post
id:nodejs-scale
title: nodejs 扩展
slug: /2020/12/18/nodejs-scale/
date: 2020-12-18T03:48:03.125Z
description: 初步认识nodejs和js
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - nodejs, js
---

运行一个service的多个拷贝，一般是有两个原因：
1. 高可用性
  如果有且只有一个实例崩溃了，那么用户就要等到实例。重启成功，才能再次使用。如果多个实例，一个坏掉了，不会影响用户的使用。
2. 吞吐量的考虑
  一个nodejs实例简单的操作吞吐量是23000 request per second。一旦进行了其他的操作，吞吐量就会下降，开启多个可以防止一个节点过劳。

### 拆分任务的工具
  > 1. cluster模块使得同一个server上运行多个app
  > 2. HAProxy 允许不同的机器上运行service 的拷贝
  > 3. SLA和load testing，通过检查基准探究service可以处理的负载量，用来决定扩展实例的个数。

### cluster模块
允许同一个机器上运行多个app的拷贝，将消息派遣到不同的拷贝上，和childs_process一样，都有一个fork方法衍生子进程。不同在于路由到来的请求机制不同。
**虽然很普遍，但是它不是做扩展的最好工具**

### cluster的短处
1. 它适用于重CPU的app，而不是IO的。主要是因为js的单线程特性，以及libuv擅长处理异步事件。
2. cluster运行在第四层， TCP/UDP的级别，没有意识到协议层。
对于有些connection不会在请求结束时，立即关闭的，比如grpc over http2，那这些的调用不会派遣到不同的worker进程上，通常会阻塞在一个进程上
3. cluster不能够总是让app变快
  例如单核的CPU上，开启了多个进程，就会导致资源竞争，这就需要OS做更多的调度工作。事实上，master进程总是在睡眠状态的，子进程们会竞争CPU周期。

> nodejs 的程序越来越复杂，经常会产生很多的进程，这些进程都可能会暴露出app的一些缺点，导致app崩溃。出于这个原因master进程要尽可能的简单，一般是重启失败worker的工作。

### reverse proxy  VS forward proxy
正向代理是client使用的，比如浏览器或者翻墙工具；反向代理是web server使用的；
> 正向代理用于用户想要绕过防火墙的限制；反向代理是server管理员来达到负载均衡和高可用的；
反向代理运行在传输层和应用层；正向代理运行在应用层；


### 反向代理应用
1. 负载均衡，将请求转发到众多server的一个
2. 健康检查
3. 清除恶意http 请求
4. 记录请求日志
5. 执行gzip
6. TLS 加密
上面有些操作比如压缩，TLS等通常比nodejs 进程快，但是因为条件的变化可能快，也可能慢。

TLS要放在一个集中的位置，好处
1. 不需要添加额外的更新证书逻辑
2. 不需要查找过气的证书操作
3. 应用server也不需要额外的CPU损耗
一般的时候，只配在web server上。


### rate limiting 和back pressure
限速和背压。SLA和LoadTesting可以用来决定nodejs server可以处理多大的负载。这里主要的问题在内存的使用。

有的时候解决问题是在特定的时间见识nodejs进程要处理的并发连接的数量
1. 设置server的maxConnections属性
  当进来的连接多于这个限制的时候，nodejs进程会自动去掉这个连接
2. server将请求放入队列

限制最好设置在webserver而不是app server，但是因不同的app server而定。

### SLA 和 负载测试
service  level agreement 服务级别协议
Service Level Objective  服务水平目标
SLA包含多个SLO。
SLO可能包含正常运行时间，Api请求延迟和请求失败率等等。
SLI 
 Service Level Indicators 服务水平指标

SLO是分子(numerator);SLI是分母(denominator)

负载测试使用Autocannon，其他还有Apache Bench，wrk, Siege.
autocannon -d 60 -c 10 -l http://localhost:4000/

对于测试结果，用户请求的整体快慢是由后端service复合的，所以就服务速度而言，选择高百分比的，TP95/99.


### 协议问题
不同的协议确实会改变负载的内容。
JSON over HTTP更快；graphql 解析器自己实现解析会慢一些；grpc使用的Buffer来序列和解序列对象。grpc在静态的编译型的语言里更快。

### 提出SLOs
当你提出SLO的时候，你要考虑到依赖的上游的话，那么上游应该是有这个指标的。否则无法确定到底是哪里出了问题。
还有一个要注意的事情serveice是否在特定的时间存在流量高峰，要确定SLOS在峰值的时候，仍能够保持住。
再有要考虑到用户的期待。autocomplete的东西100ms以内，创建bank loan 60s用户也能等待。

> 下游服务有硬性的响应时间需求，不能满足的情况下，可以多用几台server，但是更多的时候是调查code，使其变快。


**在确定SLO延迟目标的时候，要考虑多少个服务实例在运行**
https://www.linuxbabe.com/it-knowledge/differences-between-forward-proxy-and-reverse-proxy#:~:text=The%20main%20difference%20between%20the,can%20be%20on%20the%20Internet.

https://www.verygoodsecurity.com/blog/posts/proxies-demystified

