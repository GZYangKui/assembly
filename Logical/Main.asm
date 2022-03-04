extern exit_app
extern print_num

section .data
op              db               10
op1             db               25

section .text

global _start
_start:

mov al,byte[op]
mov bl,byte[op1]

;与(&)运算
and al,bl
push rax
call print_num

;或(|)运算
or al,bl
push rax
call print_num

;异或(^)
xor al,bl
push rax
call print_num

last:
call exit_app
