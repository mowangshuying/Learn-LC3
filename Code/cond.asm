;LC3 ����if 
;mowangshuying

.ORIG x3000					;�����˵�һ��ָ��ĵ�ַ
   LEA R0, enterAge			;������
   PUTS
   IN
   
   
   
Valid
	LEA R0, goodAge
	PUTS
	
   
DONE
	HALT					;������ֹ
	
	;��������
	enterAge .STRINGZ	"Enter Age:"
	goodAge	 .STRINGZ	"You Enter A Valid age"
	
	flagNum1 .FILL      x30
	flagNum9 .FILL		x57
	
	storeR0	 .FILL		
	
	;�ӳ�������
convertToInt
	
	AND R1, R1, #0
	ADD R1, R1, R0
	; C - 48 >= 0
	ADD R0, R0, #-48
	BRpz 1
	; C -57 < 0
	ADD R0, R0, #-57
	BRnz 1
	
.END		