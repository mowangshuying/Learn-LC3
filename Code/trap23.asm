;LC3 读取一个字符，存储到R0寄存器并打印到控制台上 
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
	TRAP x23				;读取一个字符，存储到R0寄存器并打印到控制台上

	HALT					;程序终止
	;数据申明
.END