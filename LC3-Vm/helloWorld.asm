;LC3 Hello World				;ʹ�� ";"��Ϊע��
;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ
	LEA R0, HW				;���ַ����洢��R0�Ĵ�����
	PUTS					;���R0�е��ַ���
	HALT					;������ֹ

						;���ݶ�������					
	HW .STRINGZ "Hello, world!"		; .STRINGZ�����ַ�����HW�����š�
.END						;Դ�����β����
