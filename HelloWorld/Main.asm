
extern exit_app
extern print_text

section .data
LF              equ            10
NULL            equ             0
msg             db    "Hello,World!",LF,NULL


section .text
global _start
_start:
mov rsi,msg
call print_text

last:
call exit_app