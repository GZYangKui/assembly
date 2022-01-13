;系统调用
section .data
;标准输出(系统调用代码)
 STDOUT    equ 1
 SYS_WRITE equ 1
 ;数组
 msg       db  "Hello,world",10,0
 msgLen    dq   12

section .text
global _start
_start:
 mov rax,SYS_WRITE
 mov rsi,msg
 mov rdx,qword [msgLen]
 syscall
 mov rax,60
 mov rdx,0
 syscall