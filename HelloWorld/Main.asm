
extern exit_app
extern print_text
extern print_num

section .data
LF              equ            10
NULL            equ             0
msg             db    "Hello,World!",LF,NULL


section .text
global _start
_start:
push $-$$
call print_num
mov rsi,msg
call print_text
last:
call exit_app