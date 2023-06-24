;LC3 汇编代码模板 
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
	AND R1, R1, #0			;给R1赋值为0 R1 = 0
	ADD R2, R1, #-8			; R1 = R1 - 8
	BRn 2					; 上一条指令运行结果为负数，则向下跳转两条语句
	ADD R2, R2, #2
	ADD R2, R2, #3
	ADD R2, R2, #8
	BRnz -4					;上一条指令执行结果小于等于0
	
	;数据申明    
	HALT					;程序终止
.END		