;LC3 .FILE .BLKW 
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址

	LD R1, MyVal1			;R1 = MyVal1
	LD R2, MyVal2			;R2 = MyVal2
	
	ADD R3, R1, R2			; R3 = R1 + R2
	ST	R3, Result			; Result = R3
	
	;数据申明
	MyVal1 .FILL 5			;分配一个存储单元并赋值为5
	MyVal2 .FILL 6			;分配一个存储单元并赋值为6
	Result .BLKW 1			;分配一个存储单元( .BLKW后面接的数字就代表分配了几个单元)
	
	HALT					;程序终止
.END		