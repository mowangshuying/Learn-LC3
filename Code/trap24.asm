;LC3 ������ģ�� 
;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ
   LEA R0, HString
   TRAP x24
	HALT					;������ֹ
	;��������
	HString 	.FILL 	x6548	;eH
				.FILL 	x6c6c	;ll
				.FILL	x206f	;\00
				.FILL	x0000	;empty
.END		