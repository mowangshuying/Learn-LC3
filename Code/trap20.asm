;LC3 trap x20
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
	TRAP x20				;获取到单个字符存储到R0寄存器中
	
	;数据申明    
	HALT					;程序终止
.END