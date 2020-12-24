---
templateKey: blog-post
id:nodejs-scale
title: nodejs 可观察性处理
slug: /2020/12/20/nodejs-scale/
date: 2020-12-20T03:48:03.125Z
description: 初步认识nodejs的ELK
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - nodejs, js， ELK
---

主要是记录下如何观察在远程机器上的Nodejsservice。

ELK是生成每个请求信息的日志记录的；Zipkin是用于追踪request的
以及不同服务的相关日志的生成；Graphite和StatsD以及Grafana是找
出影响性能的工具；Cabot是当app性能出现严重问题，下滑到阈值的时候，给开发者发送警示信息的。
Health Checks决定app如何是正常的能够服务请求的或者是异常的应该被终止。


### nodejs 的environment
环境是区分app的运行实例和数据库的概念。
重要性在于路由流量到哪个实例，指标和日志的隔离，为了安全隔离服务，切换appcode测试等等。


环境应该是彼此隔离的。最好是不同的环境在不同的机器上或者不同的虚拟私有云上


> 选择哪个code部署到不同的环境，使用哪个分支，使用什么样的合并策略，以及版本控制等等。

一般最少要有三个环境
1. development环境
  用于本地开发，其他服务可能会忽略该环境。不需要production环境的后备存储等。log会写到标准输出而不是采集器
2. staging环境
  production环境的完全拷贝，比如机器型号操作系统版本，还可能有产品数据库的匿名快照
3. production环境
   真正处理产品流量的地方。可能比staging上多更多的服务。

   ### ELK
  - Elasticsearch
  强大的query语法数据库，支持自然文本搜索的特性。一般用于建立搜索引擎。默认端口是9200；
  - logstash
  从多个源摄取和转换日志的一个服务。使用的是UDP协议。
  - Kibana
   web 服务用于对elastic search里的可视数据构建dashboard，默认端口是5601

   