section .data
SYS_exit             equ              60
exit_success         equ              0

section .text

;退出当前程序
global exit_app
exit_app:
mov rax,SYS_exit
mov rdi,exit_success
syscall