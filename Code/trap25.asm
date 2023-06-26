;LC3 程序终止
;mowangshuying

.ORIG x3000					;定义了第一个指令的地址

   TRAP x25					;程序终止 TRAP x25 = HALT
   ;数据申明 
.END		