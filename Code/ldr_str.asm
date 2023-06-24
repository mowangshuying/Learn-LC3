;LC3 ldr str 
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
	LEA R1, MyArray1		;获取MyArray1的地址，并放入R1寄存器中
	ADD R3, R3, #-2			;R3 = -2
	SDR R3, R1, #2			;将R3的值放入MyArray1[2]
	
	AND R3, R3, #0			;R3寄存器赋值为零
	LDR R3，R1, #2			;取出MyArray1[2]的值到R3寄存器中
	
	;数据申明
	MyArray1	.FILL #12	; MyArray1[0]
				.FILL #22	; MyArray1[1]
				.FILL #-7	; MyArray1[2]
	HALT					;程序终止
.END		