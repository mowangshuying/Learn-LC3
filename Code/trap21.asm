;LC3 输出字符 
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
	LD R0, MyChar			;Load 'A' into R0
	TRAP x21				;输出R0寄存器中的内容，'A'
	;数据申明
	MyChar .FILL #65		;assic 'A'
	HALT					;程序终止
.END