;LC3  if(R0 >= 0) R1 = 1
;	  else R1 = 0

;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ
   
	AND R1, R1, 0			;
	ADD R1, R1, R0			;

	BRzp 1
	BRn  3

	AND R1, R1, 0
	ADD R1, R1, 1
	BRnzp 1

	AND R1, R1, 0

	HALT					;������ֹ
	;�������� 
.END	
