# Question

## 1.编写第一个LC3程序？

对应代码：Code/helloworld.asm

```
;LC3 Hello World				;使用 ";"作为注释
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
	LEA R0, HW				;将字符串存储到R0寄存器中
	PUTS					;输出R0中的字符串
	HALT					;程序终止

						;数据定义区域					
	HW .STRINGZ "Hello, world!"		; .STRINGZ定义字符串，HW代表标号。
.END						;源代码结尾部分

```

## 2.编写一个加法，并输出内容？

详细信息：

>eg:如编写 1 + 1 = 2的例子，思路如下：
>
>	1. 存储1
> 	2. 存储1
> 	3. 做加法
> 	4. 显示

参考示例：

> Code/add1.asm

## 3. 什么是ALU？

摘录自维基百科：

>算术逻辑单元（英语:
>
>**算术逻辑单元**（英语：Arithmetic logic unit，[缩写](https://zh.wikipedia.org/wiki/縮寫)：**ALU**）是一种可对[二进制](https://zh.wikipedia.org/wiki/二进制)[整数](https://zh.wikipedia.org/wiki/整数)执行[算术运算](https://zh.wikipedia.org/wiki/算术)或[位运算](https://zh.wikipedia.org/wiki/位操作)的[组合逻辑](https://zh.wikipedia.org/wiki/组合逻辑电路)[数字电路](https://zh.wikipedia.org/wiki/数字电路)。
>
>详细信息参见：[算术逻辑单元 - 维基百科，自由的百科全书 (wikipedia.org)](https://zh.wikipedia.org/wiki/算術邏輯單元)

>此处本人简单理解为：算术和组合，如+，-，\*, / 或者是位运算等。