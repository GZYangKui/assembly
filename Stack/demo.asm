section .data
EXIT_SUCCESS equ 0
SYS_EXIT     equ 60
debugStr     dq  "execute....",10,0
numbers      dq  121,122,123,124,125
len          db  5

section .text
global _start
_start:
;使用loop(循环指令将数组元素入栈)
 mov rcx,qword [len]
 mov rbx, numbers
 mov r12, 0
 mov rax, 0
pushLoop:
 push qword [rbx+r12*8]
 inc r12
 loop pushLoop


last:
 mov rax,SYS_EXIT
 mov rdi,EXIT_SUCCESS
 syscall