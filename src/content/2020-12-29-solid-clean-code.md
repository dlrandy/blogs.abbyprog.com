---
templateKey: blog-post
id:solid-clean-code
title: solid clean code
slug: /2020/12/29/nodejs-scale/
date: 2020-12-29T03:48:03.125Z
description: 学习clean code
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js, solid, clean, code
---

### unclean code
- 不能理解的code
- 很难找到要寻找的code
- 未格式化的，不好测试的，不灵活的code
- 团队害怕去改变的code
- expensive
> unclean 的code会导致返工，浪费时间和金钱以及项目的失败；
clean code有助于培养好的习惯，遵循已知的最佳实践和负责。


### 理解clean code
Clean code在某种程度上是指code整洁度。它是遵循着最佳实践，使得
code可读可写，从而codebase的结构和样式特点都很积极。
> 也就是可读 可理解 灵活 可测试 可维护的code。

### clean code的三大支柱
1. 开发者心态
2. 编码规范
3. 技能与知识

### 开发者心态
专业精神， 从失败中成长以及设计的思考

#### 软件开发周期
Planning------>Analysis------>Design------->Implementation------->Testing&Integration----------> Maintenance------>Planning


### 为什么说Agile不好使？
 Agile要生效，必须具备两点：
 1. Process 流程
 2. 技术优势(一般都是因为技术优势的缺失，也可以认为是craftman精神)

 上面两点是Agile必须的保证增量的交付价值，而不是一次交付

    process                      Technical Excellence
  scrum                          XP(最原始的技术敏捷框架)
    - daily scrum                  - TDD
    - retrospective                - pair programming
    - backlog                      - continuous
    - sprints                    Integration
                                   - YAGNI
                                   - Simple design
                                   - DDD



  1. 易于实现                   1. 需要训练
  2. 价值容易被管理层理解        2. 价值容易不被管理层理解



### 编码规范
使用工业标准，工具和方式及方法养成自己的能够产生高质量软件的编码规范。
- project planning
  - Api优先
    适合CRUD的App；不适合domain 逻辑复杂的app
  - 数据库优先

- Documentation
- 组织结构
  它是会影响新特性的开发时间；定位新特性的时间；改变code需要的耗费的精力以及如何去加入新code。
  > - 使用规范
    1. src用于源码
    2. docs存放文档
    3. config
    4. examples
    5. build/dist用于编译后的文件
   - 保持codeDRY
   - 根据特性分组相关的文件
   - 尽可能平滑
   - screaming 架构
   - Shared
   - 小项目里通过架构分包
   - 大项目里通过特性分包


- 格式化和style
- comments
- 命名
 1. 一致性和唯一性
 2. 可理解性
 3. 特指性
 4. 简洁性
 5. 可搜索性
 6. 可发音性
 7. 朴素性
- 错误和异常处理
- Test
- 重构
- 架构基础




学习新的codebase的FeedBack Loop
  ``` javascript
  Reading --------》 coding  --------> Submission 
  适应项目          使用当前的理解      code reviews/ PR
  domain术语发现
  
  ---------->Analyze------------->improve------------>repeat-----
    comments,suggestions      revision, reflection    new task
    discussions,corrections    learning
  ---->Reading
     

```

### 技能和知识
**总结**
变的聪明和博学。精炼源于技能(新语言，工具，框架)的代码约定和知识(设计模式，原则，方法，经验 和判断)

- 可理解性和灵活性以及可维护性

  当code是可理解，灵活，可维护的时候，project变的完整了，code可以健康长寿。
    1. 手艺人感兴趣于让自己武装上那些能保持三大支柱强大的东西
    2.了解最佳实践，也知道什么时候不去准守
      - 必须知道什么打破这些原则
      - 打破这些原则有什么影响
- 软件设计和架构路线图
  clean code是起点。要投入正确的心态(同理心，成长的心态)，投入codebase规范(rules,一致性)以及持续的学习更多的软件设计的知识。

  ### 软件质量
    - 结构质量
      可以正常衡量
    - 功能质量
      只能通过测试衡量
  
#### 结构质量
可测量的属性
 1. 应用架构标准(可靠性，安全性，高效性，可维护性)
    - 多层设计兼容性(UI VA App Domain VS infrastructure/Data)
    - 数据访问性能
    - 耦合度
    - 组件或者模式的复用率
 2. 编码实践(安全性，高效性，可维护性)
    - 错误、异常处理(所有UI层、Logic、Data)
    - 可以的话，兼容OO和结构编程实践
    - 安全控制(系统功能的访问，程序的访问)
 3. 复杂性(可维护性)
    - 事务
    - 算法
    - 编程实践(多态，动态实例化等)
    - dirty programming(dead code, empty code)
 4. 文档化(可维护性)
    - code的可读性和结构
    - 架构-程序-code等级别的文档化比重
    - 源码文件组织
 5. 可移植性
   硬件，操作系统和软件以及Db的依赖程度
 6. 技术和功能的体量(size，可维护性)
   - 文件，人工品，每个技术的代码行数
   - 功能点 遵循规范(IFPUG, Cosmic refernces)
https://en.wikipedia.org/w/index.php?curid=32370588

#### 编程错误的报告
编程错误和产品缺陷的关联度揭露了code错误占源码总错误的92%。这些代码级别的错误最终只占产品缺陷的10%。架构级别的不佳工程化实践只占用整体缺陷的8%，但是要花费一半的人工修复问题，并会导致产品上90% 的严重可靠性安全性和效率问题。

### 如何去测量软件的结构质量
- code smell (提示着可能有较大的设计问题)
 一般分为三类：
 1. 应用级别
 2. class 级别
 3. 方法级别
 > code smell依赖语言，context，developer。每个语言都有自己的规范。对于不同的环境，一般web开发中将God对象作为codesmell的，但是在微控制器开发中，这个确实性能增加的方式, 在这里性能比可维护性更重要。
- 反模式
 一些对于常见的问题的解决方式，但是这些方式是公认的不好的方式。这些方法多少会是不高效的，混乱的或者对设计有害的。
  -  soft-code
    存储业务逻辑在配置文件里，而不是源代码里。当配置文件变成源码，源码变成抽象的时候，理解和维护的问题就出来了。
  - interface bloat
    使得接口健壮的挑战在于实现。通常要interface是相对较小的
 > 
  1. 什么是反模式，是不能确定的。取决于编程人员，项目，软件开发理论/方式以及环境。
  2. Anemic Domain Models VS. EntityComponent System
   Anemic Domain model是反模式，它是是指model的业务逻辑不存在model里时开发的事物，业务则是落在services，controllers或者helper类里。 它会导致大量的重复code。web开发上我们不需要这种模式，但是在游戏编程领域，model和model的操作分离确实完美的，并作为EntityComponentSystem的一条准则。比如游戏一开始的时候，角色是一个人，可以移动，但是找到特殊属性的时候，变成另外一种角色，但是仍然是以人的速度移动。移动的行为从人，盒子，花，鞋等抽离出来。这样就可以在model接入新的属性的时候，直接变成另外一种模型，而不用担心每个model的移动方式。反模式一般是解决问题的成熟的方式。
- DRY VS overengineering
  践行DRY更靠近过度工程化；重复自己在一些情况下是使得code更能让人理解可读。
  > 计算机科学实际上是权衡利弊的游戏，过度工程化是用可读性换取抽象，这又是不可取的。因为不能理解和修改的code脱离了软件最基本的目标。记住**总是将人放在第一位**
### code优化
给人优化code意味着使code易于读和理解；给机器优化从而意味着code更高效；给机器的优化一般会损害给人的优化。

### clean coder指导原则
1. 重度关心项目(project)和领域(domain)
  与不介意一起工作的人一起从事你喜欢的工作，或者深入某个有潜力的领域；对项目的成功有热情；善于理解其他的开发者的工作生活。
  不能写出clean code的原因
    1. 你讨厌你的工作
    2. 你要离开公司
    3. hacky project(临时项目)
    4. 你是唯一开发项目的人
    5. 项目进展不顺利像是向着死亡行军
2. 旨在授权同事和未来的维护者
  你的目标应该是能够让其他的开发者觉得他们擅长他们的工作。他们应该能够快速的安全的理解，定位和改变code。把你写的code放在同事的面前，要他们去理解，定位以及改变特性。这么做决定你的同情代码能力是否需要调整。
3. Humans优先于机器
4. 约定和模式是有用的，但是它们是你的用户和维护者的第二选项
  强化约定，设计模式和设计原则，不会损害其他开发者赋能的话，是可以强化的。
  > 如果这些不能赋能团队或者未来维护人员的话，都是次要的(DRY, Abstraction,coding convention等)
