;LC3 .FILE .BLKW 
;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ

	LD R1, MyVal1			;R1 = MyVal1
	LD R2, MyVal2			;R2 = MyVal2
	
	ADD R3, R1, R2			; R3 = R1 + R2
	ST	R3, Result			; Result = R3
	
	;��������
	MyVal1 .FILL 5			;����һ���洢��Ԫ����ֵΪ5
	MyVal2 .FILL 6			;����һ���洢��Ԫ����ֵΪ6
	Result .BLKW 1			;����һ���洢��Ԫ( .BLKW����ӵ����־ʹ�������˼�����Ԫ)
	
	HALT					;������ֹ
.END		