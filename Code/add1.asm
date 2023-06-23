;LC3 加法示例：如 1+1 = 2
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址

    ;以下两句代码的作用是给R0寄存器赋值为1，先给R0 & 0 = 0, 然后 R0 + 1 = 1
    AND R0, R0, #0          ; #0代表十进制下的零
    ADD R0, R0  #1          

    ;给R1寄存器赋值为1
    AND R1, R1, #0
    ADD R1, R1, #1

    ;计算结果并存放至R3中
    ADD R3, R0, R1

    ;输出R3寄存器中的内容
    ;参考：https://comp-org-etext.netlify.app/Assembly/BasicIO/LC3IO.html#display-data-register => BasicIO => LC3 input/ouput => example code
	
	;轮询等待DSR最高位置为1就可以显示了
	LOOP	LDI	R0 DSR
			BRzp LOOP
	
	LD R0, Num0			;加载Num0数据到R0寄存器
    ADD R3, R3, R0 	;R3 = R3 + R0
    STI R3, DDR     	;R3的值送入DDR中
	
	;数据申明
	Num0	.FILL 0x30		;assic码 0 对应的16进制为 0x30, 
	DSR		.FILL 0xFE04	;最高位为1表示可以向屏幕输出一个字符
	DDR		.FILL 0xFE06	;向屏幕输出字符的ascii码存在其低8位
    
	HALT					;程序终止
.END		