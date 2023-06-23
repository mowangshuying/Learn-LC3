;LC3 alu not 
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址

	AND R0, R0, #0			;R0 = 0
	NOT R1, R0				;R1 = ~R0 = xFFFF
	NOT R2, R1				;R2 = ~R1 = 0
	
	;数据申明    
	HALT					;程序终止
.END		