---
templateKey: blog-post
id:nodejs-messaging-integration-patterns
title: nodejs messaging integration patterns
slug: /2021/01/21/nodejs-messaging-integration-patterns/
date: 2021-01-21T03:48:03.125Z
description: 学习 nodejs-messaging-integration-patterns
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js,nodejs,messaging,integration,patterns
---

可扩展性是关于分发系统的，集成则是将它们相连的。

### 整合分布式应用的两种方法：
1. 使用共享存储作为中央协调器和所有信息的看护人；
2. 使用messages去在系统的多个节点传播数据，事件和命令

> 在分布式架构中，messaging system是用来描述一类方案，模式和架构的，它们是用来方便互联网上的信息交换的。

### messaging system基础
1. 通信的方向，可以是单向也可以是request/reply
2. message的目的，这个决定了message的内容
3. message的时间安排，环境内接受和发送(同步)；环境外接受和发送(异步)。
4. message的传递方式，直接还是通过broker

#### one way VS request/reply 模式
one-way的通信，比如不需要回复的email 或者server将message发送浏览器，或者system将任务分发任务给worker；

Request/Reply
一般是一个方向的message匹配反向的message。

一般可分为简单的request/reply 通信模式和多节点request/reply通信模式。

### message types
根据目的不同，分为：
1. Command 信息
    触发接受者的动作或者任务。这种message多用于RPC，分布式计算，或者请求一些数据。
2. Event 信息
    通知一些组件发生了某事
3. Document 信息
   主要是为了在组件之间或者机器之间传输一些数据。

### 异步的messageing， queue，和stream
相比于queue，stream里，在message被处理和接受的时候，message并不会被移除。stream提供了更多的自由访问message；而queue只会暴露一次message给使用者。而且stream可以共享给多个使用者。


### 消息的传递方式
1. peer-to-peer
  消息直接传递
2. 基于broker
消息经过message broker是为了解耦消息的发送者和接受者。

> 在perr-to-peer的架构中，每个node都要直接传输message给接受者，也就屙屎node必须知道接受者的地址同时也要协商好协议和消息的格式。在broker下，每个节点完全独立可以和不定量的node通信，而不需要知道他们的细节信息。

broker可以提供额外的特性比如持久化队列，路由，消息转换和监控等。peer-to-peer也可以实现这些特性，但是成本会很高。

一些必须使用peer-to-peer的原因：
1. 移除broker，移除了导致了系统的单一节点失败
2. broker必须是可扩展的，而peer-to-peer只需要扩展单个节点
3. 没有中间人的通信延迟更低

### 发布订阅模式
是单向的消息模式。它可以为peer-to-peer和broker模式。


#### 使用Redis作为发布订阅的broker
内存的数据结构存储，broker性能非常的简单和基础相比于其他的面向消息的中间件，这也是它流行的原因

#### 使用ZeroMQ进行peer-to-peer的发布订阅
Zeromq有两种socket：PUB和SUB。


### 使用queues进行可靠的message传递
messaging system一个重要的抽象是message queue(MQ)。使用MQ不需要sender和receiver都是激活的和已经建立了通信。queuing system会存储信息直到目的地可以接收。

消息队列多用于消息不能丢失的情况。队列可以实现持久化subscriber模式---即便消息发出时，没有监听，subscriber连接到queuing 系统的时候仍能接收到。


messaging 系统的传输语义分为三类：
1. 最多一次
2. 最少一次
3. 精准一次


### AMQP
是队列消息系统支持的开放标准协议。除了定义通用的通信协议，还提供了一个model来描述routing，filtering,queuing,reliability和security。



#### AMQP broker的三个组件
1. Queue
    存储client使用的消息，它里面的消息可以push或者pull到多个使用者。对于同一个队列的多个使用者，还可以进行负载均衡
    类型：
    - Durable
      broker重启，队列自动重建，但也不意味着队列的内容会保存；内容除非保存到硬盘上，才可以恢复
    - Exclusive
      只绑定发哦一个特定的subscriber连接上。连接关闭，队列销毁。
    - Auto-delete
      当最后一个subscriber取消连接，queue会被删除

2. Bindings
   连接exchange和queue。定义路由键值和过滤消息的模式
3. Exchange
   发布消息的地方。将消息路由到一个或者多个队列中
    依赖的算法：
    - Direct
      转发匹配路由键值的消息
    - Topic
      分发消息匹配路由键值模式的消息
    - Fanout
      将消息广播到所有的队列。也可以定义路由key和模式

client创建channel(抽象连接)来维护和broker的通信状态

AMQP虽然复杂，但是可以提供一些特性和可靠级别，这些事光靠基本的发布订阅机制是很难获得的。

### streaming 平台的特点
1. stream是一个有序的只追加，持久化的数据结构， record使用完不会自动删除；
2. 记录是用户自己从stream里拉取的，允许用户自行控制记录的处理速度


### Streams  VS message queues
streams适合处理顺序的数据。
message queue和streams都适合实现发布订阅的模式；
message queues更适合于复杂的系统集成任务，因为可以提供高级路由，优先级等。



### Redis stream
目前最流行的streaming平台是Apache kafaka和Amazon的Kinesis，对于简单的任务也可以使用Redis Stream，他使用的是一个log的数据结构。

stream先天就不会丢失message。


### Task 派发模式 (消费者竞争模式)
将任务散发给不同的机器，这些任务可以是工作的一部分或者大任务里一块小任务，在这里的划分使用的是分治算法。

这个模式和负载均衡不同，在于consumer更为积极。大多数的时候不是producer连接到consumer，而是consumer连接到task producer或者task queue。

> 常规的messaging 系统，不需要在producer和worker之间有request/reply的这种通信，大多数是使用单向的异步同信，这样有更好的平行性和可扩展性。这样的架构了，消息是单向传递的，需要创建pipelines。

> pipelines可以构建复杂的处理结构，而没有同步request/reply的那种成本，而且还是低延迟和高吞吐量。task 派发模式

