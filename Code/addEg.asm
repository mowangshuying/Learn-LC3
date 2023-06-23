;LC3 alu add
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
	
	; 给R1赋值为1
	AND R1, R1, #0
	ADD R1, R1, #1
	
	; 给R2赋值为2
	AND R2, R2, #0
	ADD R2, R2, #2
	
	
	; 给R3赋值为0
	AND R3, R3, #0
	
	; R3 = R1 + 1
	ADD R3, R1, #1	; R3 = R1 + 1						=> R3:2
	ADD R3, R2, #-4	; R3 = R2 + (-4)					=> R3:-2
	ADD R3, R3, xB  ; R3 = R3 + xB = R3 = R3 + 11		=> R3:9
	ADD R3, R3, b0111 ; R3 = R3 + b0111 = R3 + 7		=> R3:16
	
	
	;数据申明    
	HALT					;程序终止
.END		