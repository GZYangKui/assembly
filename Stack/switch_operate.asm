section .data
SYS_exit        equ      60
EXIT_SUCCESS    equ      0
a               dq       15
b               dq       20

section .text
global _start
_start:
 push qword [b]
 push qword [a]
 call switch_operate
 lea rax,qword [a]

last:
 mov rax,SYS_exit
 mov rdi,EXIT_SUCCESS
 syscall

;交换a和b的值函数实现
global switch_operate
switch_operate:
 push rbp
 mov rbp,rsp
 ;栈向下扩展8个字节用于中间交换所用
 sub rsp,8
 mov rax,qword [rbp+16]
 mov qword [rbp-8],rax
 mov rbx,qword [rbp+24]
 mov rax,rbx
 mov rbx,qword [rbp-8]
 mov qword [a],rax
 mov qword [b],rbx
 mov rsp,rbp
 pop rbp
 ret