;LC3 alu add
;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ
	
	; ��R1��ֵΪ1
	AND R1, R1, #0
	ADD R1, R1, #1
	
	; ��R2��ֵΪ2
	AND R2, R2, #0
	ADD R2, R2, #2
	
	
	; ��R3��ֵΪ0
	AND R3, R3, #0
	
	; R3 = R1 + 1
	ADD R3, R1, #1	; R3 = R1 + 1						=> R3:2
	ADD R3, R2, #-4	; R3 = R2 + (-4)					=> R3:-2
	ADD R3, R3, xB  ; R3 = R3 + xB = R3 = R3 + 11		=> R3:9
	ADD R3, R3, b0111 ; R3 = R3 + b0111 = R3 + 7		=> R3:16
	
	
	;��������    
	HALT					;������ֹ
.END		