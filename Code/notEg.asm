;LC3 alu not 
;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ

	AND R0, R0, #0			;R0 = 0
	NOT R1, R0				;R1 = ~R0 = xFFFF
	NOT R2, R1				;R2 = ~R1 = 0
	
	;��������    
	HALT					;������ֹ
.END		