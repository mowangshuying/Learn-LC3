;LC3 Hello World				;使用 ";"作为注释
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
	LEA R0, HW				;将字符串存储到R0寄存器中
	PUTS					;输出R0中的字符串
	HALT					;程序终止

						;数据定义区域					
	HW .STRINGZ "Hello, world!"		; .STRINGZ定义字符串，HW代表标号。
.END						;源代码结尾部分
