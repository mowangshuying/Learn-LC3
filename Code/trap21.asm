;LC3 ����ַ� 
;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ
	LD R0, MyChar			;Load 'A' into R0
	TRAP x21				;���R0�Ĵ����е����ݣ�'A'
	;��������
	MyChar .FILL #65		;assic 'A'
	HALT					;������ֹ
.END