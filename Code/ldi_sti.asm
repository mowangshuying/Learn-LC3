;LC3 ldi �� sti 
;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ
	AND R0, R0, #0			;R0 = 0
	ADD R0, R0, #1
	
	STI R0, MyAddr1			;��R0���ݴ�ŵ�x7000��λ�� 
	LDI R1, MyAddr1			;���� x7000 λ�õ����ݵ� R0�Ĵ�����
	;��������
	MyAddr1 .FILL x7000
	HALT					;������ֹ
.END		