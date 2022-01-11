section .data
 var   db    7
 var1  db    6
 sum   db    0
 ;var2和var3变量均已经超过当前计算机能够处理最大位数
 var2  ddq  0x1A000000000000000
 var3  ddq  0x2C000000000000000
 dqSum ddq  0

section .text
global _start
_start:
  mov al,byte [var]
  add al,byte [var1]
  mov byte [sum],al
  ;大数相加 var2+var3
  ;取低8字节数据放入rdx中
  mov rax,qword [var2]
;  ;取余下8字节数据放入rdx中
  mov rdx,qword [var2+8]
  add rax,qword [var3]
  adc rdx,qword [var3+8]
  mov qword [dqSum],rax
  mov qword [dqSum+8],rdx
  ;减法
  mov al, byte [var1]
  sub al, byte [var]


last:
 mov rax,60
 mov rdx,9
 syscall