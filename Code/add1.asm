;LC3 �ӷ�ʾ������ 1+1 = 2
;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ

    ;�����������������Ǹ�R0�Ĵ�����ֵΪ1���ȸ�R0 & 0 = 0, Ȼ�� R0 + 1 = 1
    AND R0, R0, #0          ; #0����ʮ�����µ���
    ADD R0, R0  #1          

    ;��R1�Ĵ�����ֵΪ1
    AND R1, R1, #0
    ADD R1, R1, #1

    ;�������������R3��
    ADD R3, R0, R1

    ;���R3�Ĵ����е�����
    ;�ο���https://comp-org-etext.netlify.app/Assembly/BasicIO/LC3IO.html#display-data-register => BasicIO => LC3 input/ouput => example code
	
	;��ѯ�ȴ�DSR���λ��Ϊ1�Ϳ�����ʾ��
	LOOP	LDI	R0 DSR
			BRzp LOOP
	
	LD R0, Num0			;����Num0���ݵ�R0�Ĵ���
    ADD R3, R3, R0 	;R3 = R3 + R0
    STI R3, DDR     	;R3��ֵ����DDR��
	
	;��������
	Num0	.FILL 0x30		;assic�� 0 ��Ӧ��16����Ϊ 0x30, 
	DSR		.FILL 0xFE04	;���λΪ1��ʾ��������Ļ���һ���ַ�
	DDR		.FILL 0xFE06	;����Ļ����ַ���ascii��������8λ
    
	HALT					;������ֹ
.END		