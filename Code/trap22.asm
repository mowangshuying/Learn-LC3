;LC3 ��ӡ�ַ��� TRAP x22 
;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ
	LEA R0, HWString		;��HWString�ĵ�ַ����R0��
	TRAP x22				;����ַ���
	
	HALT					;������ֹ
	
	; ��������
	HWString .STRINGZ "hello,world!"
.END		