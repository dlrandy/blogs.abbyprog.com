---
templateKey: blog-post
id:nodejs-common-recipes
title: nodejs common recipes
slug: /2021/01/19/nodejs-common-recipes/
date: 2021-01-19T03:48:03.125Z
description: 学习nodejs-common-recipes
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js,nodejs,recipes
---

### 组件异步初始化问题
问题的解决方案：
1. 本地初始化检查
2. 延迟启动
3. 预初始化队列
  确保组件的服务只在组件初始化之后调用，使用了队列和command模式
4. 预初始化队列的state模式实现

### 异步请求的批处理和缓存
请求的批处理是指调用一个异步函数的同时，已经有另一个同样函数挂起了，就可以等待已有的函数运行完，而不用新起一个请求。

### 最优的异步请求缓存
只要请求完成了，将结果存储在cache里，下次调用函数时候，直接返回结果。
通常这个方法要和request batching一起使用。

> 对于缓存操作，要小心Zalgo问题。因为处理的是异步的API，所以要确定总是异步的返回缓存值，即便访问cache是一个同步的操作。

### 使用promises批量和缓存
主要是因为promise的两个特点：
1. 多个then的监听器可以附加在同一个promise上
2. then监听器只保证调用一次而且是异步的


#### 缓存机制要注意的事项
1. 大量的缓存消耗太多的内存，可以使用Least Recently Used(LRU)或者first in first out(FIFO)来维持内存的使用情况。
2. 对于分布式的应用，每个server实例都有自己的缓存会产生不同的结果，所以需要共享缓存。
3. 手动失效缓存，和定时过期相反，可以启动更长效的缓存同时提供最新的数据，但是缓存的管理比较复杂。

**计算机世界只有两个难事：缓存失效和命名**

### 取消异步操作
promise的规范了不包含取消promise；但是第三方实现比如bluebird等是支持的。


### 可扩展性
nodejs的单线程非阻塞特性天生适合分布式。

> APP的扩展性不止是强大的性能快速的处理更多的请求；还包括更高的可用性和容错率。

可扩展性被描述为系统的成长和适应不断变化的条件的能力。

nodejs如果用于高负载的APP，唯一的办法就是扩展到多个process和machines。


### 扩展性的三个维度
1. cloning
2. decomposing by service/ functionality
3. splitting by data partition


### cloning 和负载均衡
在nodejs里vertical scaling是指单个机器增加更多的资源；horizontal scaling是指基础设施上添加更多的机器。扩展也是会影响可用性和容错率的。
> 应用早期思考可扩展性，可以确保APP不依赖被多个进程和机器共享的资源

### cluster
适合单个机器上将app的负载分布到多个app的实例上。大多数系统的cluster会使用round-robin的负载均衡算法。master进程使用这个算法，将请求均匀的发布到所有的worker上。windows上默认不是这个算法。可以通过cluster.schedulingPolicy 修改。

**cluster 的server.listen的一些边缘情况**

### cluster的弹性和可用性
所有的worker使用的都是独立进程。可以根据需要杀死和重新衍生进程。只要有些worker是活的，server就会继续接受请求，否则就会拒收请求。

**PM2是基于cluster的**


### 0宕机重启
一些APP是不能因为更新就有一小段时间不接收请求的。也就是app更新不影响可用性。

nodejs重启的时候会接受SIGUSR2的信号事件。


### 处理有状态的通信
cluster并不能很好的处理不同的实例之间的共享状态。因为属于同一个状态session的不同的请求可能被不同的app实例处理。cluster通常适用于无状态和负载均衡算法的

> 对于cluster上面的问题：
1. 在所有实例中共享state。可以经由共享的数据库或者缓存来实现。
 
 缺点：需要大量的重构，因为之前适用的内存状态，现在要切换到共享的存储上。


2. 粘性负载均衡(粘性session)
负载均衡将所有和某个session相关的请求都转发到同一个app的实例。通常是检查sessionID或者是IP地址。

   缺点在于没有了冗余系统的大多数好处。特别是在一个不工作的实例被另一个实例替代了的情况。

### 使用反向代理进行扩展
运行多个实例在不同的端口或者机器上，使用reverse proxy提供这些实例的访问和流量的转发。
选择反向代理的原因：
1. 可以将负载发布到㓊的机器上，不仅仅是进程
2. 一般都是支持粘性复杂均衡的
3. 可以路由请求到任何可用的server
4. 可以选择更强悍的负载均衡算法
5. 一般带有额外强大的特性

> Nginx,Haproxy 

### 动态的水平扩展
基于云的基础设施的一个重要的优势是基于当前和可预测的流量来动态的调整app的性能。但是这个机制需要负载均衡器总是知道最新的网络拓扑，任何时候都要知道哪些server是运行着的。

### 使用service registry
针对云服务的网络拓扑问题，通常是使用一个中心的仓库，来追踪运行的server和他们提供的服务。


### Peer-to-peer的负载均衡
反向代理一般是暴露复杂的内部网络架构给公网。但是对于扩展只在内部使用的serveice需要实现的是Peer-To-Peer的负载均衡。
但是这个需要每个service实现自己的负载均衡算法。

### 使用container扩展app
container的强大只有在APP特别复杂的情况下展现出来。比如app是由多个独立的服务组成，并且这些服务是由多个云server部署协调的。这种情况单使用Docker是不够的，需要的container orchestrate tools来将所有的容器实例进行协调。这个tools 比如kubernetes。

容器的编织工具有很多责任：
1. 允许多个节点(云server)联合成一个逻辑cluster，每个节点的动态的删除和增加不会影响其他的运行的节点

2. 可以确保0宕机。如果节点停止或者不响应健康检查，节点会自动重启。一个节点坏掉了可以代理其他的节点
3. 提供了service discovery和负载均衡功能
4. 对持久存储提供了编织访问，以至于数据持久需要
5. 自动的推出和回退，同时不会宕机
6. 敏感信息的，秘密存储和配置管理系统

Kubernetes对象是一个目的记录，一旦在kubernetes cluster上创建一个kubernete对象，kubernetes就会不断的监控对象的状态变化，确保它和定义的期望兼容。


### 单片架构
单片的系统也有高度的模块化架构和内部组件之间的解耦。比如Linux OS的内核。Linux所有的服务和模块是以kernel的形式运行的，也就是一个错误整个OS就崩溃了。而微内核则是只有核心的几个服务以kernel的模式运行，其他的以用户模式运行。

#### 单片系统的缺点
1. 每个模块都是同一个codebase的一部分，作为app的一部分运行，一旦某个模块挂掉整个系统就无法正常运行了
2. 模块之间是互相连接的，维护这种低耦合性在单片系统里成本很高的。因为彼此的界限不明确也不能适当的强化。高耦合性比较明显，会阻碍APP的发展和扩展性。

### 微服务架构
把一个大的应用分解成基本的组件，创建独立的多个app。也就是使得每个程序只做好一件事。
微服务是一组自给自足的服务替换掉一个大的单片应用。
它的划分原则在于低耦合，高内聚和集成复杂度。

### 微服务的优缺点
1. 每个服务都是可退出的
  一个service坏掉不会影响其他的
2. 跨平台和语言的可复用性
  信息的隐藏度更高
3. 扩展APP的一种方式
  它实际上是通过service或者功能来分解一个系统
4. 微服务的挑战是就集成和部署和code共享而言，引入了较高的复杂性。

### 微服务架构的集成模式
微服务的挑战之一就是连接所有的node，使得他们可以协同工作

1. API proxy(gateway) 模式
一个server代理client和一组apis的所有通信。主要的目的是提供给所有API接点一个单一的入口，同时提供负载均衡，缓存，授权和流量限制等特性

它抽离了连接到API的复杂性，允许自由重组不同的service。这种集成是结构上的，没有语义机制。它仅是提供了复杂微服务架构的一个熟悉的单片视图。



2. API orchestration
一个抽象层将一些碎片的service连接形成新的service，专门用于一个特别的应用

这个模式有助于client app的解耦。和API  Proxy orchestrator进行了不同服务的语义整合，不是原生的proxy，暴露的api通常是由多个service组成的。

该模式易于设计调试和扩展，但是，他必须要完全的了解底层的架构和各个service的工作方式。这个orchestrator也就是我们所说的God Object---知道和做的太多，通常会导致更高的耦合，低内聚和高复杂性，

3. 使用message broker
是将同步整个系统的消息的责任下发到每个service。使用message broker解耦消息的sender和receiver，可以实现集中化的发布订阅模式

### child processes  VS Cluster VS worker threads
child_process 是衍生新的进程，有自己的内存。进程之间使用IPC通信。

### child process
spawn可以是任何在命令行运行的命令；
fork用于接模块路径，比spawn好在于可以进行父子通信。

它的问题在于：
1. 只有父子通信，孩子之间不能通信
2. 孩子有独立的内存，意味着有时间和资源的成本

### worker threads
线程是共享内存的；可以线程间通信


cluster主要是垂直扩展web server。是建在child_process模块之上。使用的child_process.fork()方法，主仆架构是主进程是转发进来的请求到child process以环带的心事