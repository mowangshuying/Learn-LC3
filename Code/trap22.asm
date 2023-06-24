;LC3 打印字符串 TRAP x22 
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址
	LEA R0, HWString		;将HWString的地址存入R0中
	TRAP x22				;输出字符串
	
	HALT					;程序终止
	
	; 数据声明
	HWString .STRINGZ "hello,world!"
.END		