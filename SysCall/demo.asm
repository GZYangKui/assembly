;系统调用
section .data
;标准输出(系统调用代码)
 STDOUT    equ 1
 SYS_WRITE equ 1
 msg       db  "Hello,world"
 msgLen    dq   11

section .text
global _start
_start:
 mov rax,SYS_WRITE
 mov rdi,STDOUT
 mov rsi,msg
 mov rdx,qword [msgLen]
 syscall
 mov rax,60
 mov rdx,0
 syscall