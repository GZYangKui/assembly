;
;本程序实现输出9*9乘法表
;
section .data
 SYS_exit    equ          60
 SYS_write   equ          1
 STD_OUT     equ          1
 EXIT_SUCC   equ          0
 rows        equ          9
 columns     equ          9
 LF          equ          10
 NULL        equ          0
 outStr      dq         "AAAAAAAA",LF,NULL
 outStr1     dq         "qqqqqqqqqqqqqqqqqqqqqqqqqq"

section .text
global _start
_start:

call printStr


last:
 mov rax,SYS_exit
 mov rdi,EXIT_SUCC
 syscall

global printStr
printStr:
 push rbp
 mov rbp,rsp
 mov rbx,outStr
 mov rdx,0
 strCount:
 cmp byte [rbx],LF
 je strCountEnd
 inc rdx
 inc rbx
 jmp strCount
 strCountEnd:
 mov rax,SYS_write
 mov rdi,STD_OUT
 mov rsi,outStr
 syscall
 mov rsp,rbp
 pop rbp
 ret