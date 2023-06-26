;LC3  if(R0 >= 0) R1 = 1
;	  else R1 = 0

;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
   
	AND R1, R1, 0			;
	ADD R1, R1, R0			;

	BRzp 1
	BRn  3

	AND R1, R1, 0
	ADD R1, R1, 1
	BRnzp 1

	AND R1, R1, 0

	HALT					;程序终止
	;数据申明 
.END	
