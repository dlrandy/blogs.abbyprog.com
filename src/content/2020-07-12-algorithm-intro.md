---
templateKey: blog-post
id: algorithm-intro
title: 算法简介
slug: /2020/07/13/algorithm-intro/
date: 2020-07-12T03:48:03.125Z
description: 时间复杂度和空间复杂度初步认识。
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - algorithm
---
### 什么是算法
是解决问题的一个方法或者一个过程，也就是若干条指令组成的有穷序列。
### 算法的性质
1.输入
2.输出
3.确定性
4.有限性
> 程序是算法的某种语言的具体实现
### 设计算法的原则
设计算法时的一个主要就是设计出算法复杂性低的算法，也就是时间和空间的复杂性都很低，越低占用的资源越少。
算法的复杂度取决于问题的规模，算法的输入和算法本身的函数实现。
### 时间空间复杂性
衡量算法好坏的标准：
在能够解决问题的情况下
1. 算法需要的时间的多少
2. 算法需要的内存的多少

###Big O
它是标准的数学方式，用来描述算法的时间复杂性和空间复杂性。
主要是根据输入规模的增长来描述算法的运行时间和需要的空间的增长程度。所以结果中非主要的常量可以直接拿掉。
> 一种相对的概念，来展示算法执行时间的快慢或者依赖输入规模的内存使用的情况。相对的意思是时间和内存会因为不同的硬件，最终的结果值是不一样的。

Big  O 定义的是input  size --> spent time的时间复杂性；input size --> consumed memory 的空间复杂性。
> 描述复杂性的时候，必须要拿掉非主要的部分计算。e.g. O(n+1) => O(n)。Big O描述的是函数的秩，而不是准确的执行时间或者使用的内存数量。也就是描述趋势。时间复杂性可以看操作次数随着输入的变化的变化；空间复杂度可以看变量的数量随着输入变化的变化。

![trend](https://i.imgur.com/n1zzzfV.png 'func')


#### O(1)
``` javascript
export function thePower(number, power) {
	return number ** power;
}
/**
考虑函数的输入对操作次数的影响？
	任何的输入，函数都只做一次操作。所以时间复杂度为1；
再考虑函数执行需要的内存
	操作变量的数量不依赖输入，所以空间复杂度为1
*/
```
#### O(n)
``` javascript
export function otherPower(number, power) { 
	let result = 1;
	for (let i = 0; i < power; i += 1) {
		result *= number;
	}
	return result;
}
/**
考虑函数的输入对操作次数的影响？
	任何的输入，函数做一次操作result = 1, power次的result*= number,一次return result。所以时间复杂度为O(1) + O(power) + O(1) =>O(power) => O(n)；
再考虑函数执行需要的内存
	操作变量的数量不依赖输入,只有一个result，所以空间复杂度为1
*/
export function factorial(number) {
	if (number === 0) {
		return 1;
	}
	return factorial(number - 1) * number;
}
/**
考虑函数的输入对操作次数的影响？
	任何的输入，都要递归执行n次，e.g. f(4) = f(3) * 4; f(3) = f(2) * 3;f(2) = f(1)*2; f(1) = f(0)*1;f(0)=1;。所以时间复杂度为O(1) + O(n)  => O(n)；
再考虑函数执行需要的内存
	从例子中可以看出需要存储f(3),f(2),f(1),f(0)，所以空间复杂度为O(n)
*/
```
#### O( n&sup2; )
``` javascript
export function pairs(letters) { 
	const result = [];
	for (let i = 0; i < letters.length; i += 1) { 
		for (let j = 0; j < letters.length; j += 1) {
			result.push(`${letters[i]}${letters[j]}`); 
		} 
	} 
	return result; 
}
/**
考虑函数的输入对操作次数的影响？
	任何的输入，函数外层要循环n次，内层也要n次。所以时间复杂度为O(letters.length * letters.length) =>O(letters.length**2) => O(n**2)；
再考虑函数执行需要的内存
	存储的数量为letters.length * letters.length，所以空间复杂度为O(n ** 2)
*/
```

### 空间复杂性 VS 辅助空间复杂性
辅助空间不包含储存输入数据的内存。只存储解决问题时候需要的额外内存。
空间复杂性包含辅助空间。
> 空间复杂性 = 输入 + 辅助空间复杂性

``` javascript
 export function multiplyArray(array, multiplier) { 
 	const multipliedArray = [...array]; 
	for (let i = 0; i < multipliedArray.length; i += 1) { 
		multipliedArray[i] *= multiplier; 
	} 
	return multipliedArray;
}

/**
考虑函数的输入对操作次数的影响？
	任何的输入，函数要循环n次。所以时间复杂度为O(array.length)  => O(n)；
再考虑函数执行需要的内存
	输入需要的存储的数量为O(array.length)，辅助空间为O(array.length),所以空间复杂度为O(n * 2) => O(n)
*/
```





