---
templateKey: blog-post
id: docker-mysql
title: docker-mysql
slug: /2020/08/03/docker-mysql/
date: 2020-08-03T03:48:03.125Z
description: docker mysql set up
headerImage: https://i.imgur.com/IONCWVd.jpg
tags:
  - docker, mysql
---

直接拉取mysql的images

``` bash
docker pull mysql/mysql-server:latest

docker images

docker run --name mysql -p 3306:3306 -v /opt/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -d image_id

docker exec -it container_id /bin/bash

mysql -uroot -p


```

[参考链接](https://phoenixnap.com/kb/mysql-docker-container)
![FYI](https://i.imgur.com/LalbenT.jpg)




