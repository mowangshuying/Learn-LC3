;LC3 ldr str 
;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ
	LEA R1, MyArray1		;��ȡMyArray1�ĵ�ַ��������R1�Ĵ�����
	ADD R3, R3, #-2			;R3 = -2
	SDR R3, R1, #2			;��R3��ֵ����MyArray1[2]
	
	AND R3, R3, #0			;R3�Ĵ�����ֵΪ��
	LDR R3��R1, #2			;ȡ��MyArray1[2]��ֵ��R3�Ĵ�����
	
	;��������
	MyArray1	.FILL #12	; MyArray1[0]
				.FILL #22	; MyArray1[1]
				.FILL #-7	; MyArray1[2]
	HALT					;������ֹ
.END		