;LC3 ldi 与 sti 
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
	AND R0, R0, #0			;R0 = 0
	ADD R0, R0, #1
	
	STI R0, MyAddr1			;将R0数据存放到x7000的位置 
	LDI R1, MyAddr1			;加载 x7000 位置的数据到 R0寄存器中
	;数据申明
	MyAddr1 .FILL x7000
	HALT					;程序终止
.END		