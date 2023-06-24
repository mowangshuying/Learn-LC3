;LC3 汇编代码模板 
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
   LEA R0, HString
   TRAP x24
	HALT					;程序终止
	;数据申明
	HString 	.FILL 	x6548	;eH
				.FILL 	x6c6c	;ll
				.FILL	x206f	;\00
				.FILL	x0000	;empty
.END		