section .data
LF              equ            10
NULL            equ             0
SYS_write       equ             1
SYS_OUT         equ             1

section .text

;
;封装通用控制台输出文字信息,调用该函数仅需将字符串地址放入rsi寄存器中即可(注意字符串必须以NULL结尾,否则程序可能异常)
;
global print_text
print_text:
; 保存寄存器信息
push rdi
push rax
push rdx
mov rdx,0
;统计字符串长度,以NULL值结尾
countLoop:
mov al,byte [rsi+rdx]
inc rdx
cmp al,NULL
jne countLoop
;系统调用输出控制台
mov rdi,SYS_OUT
mov rax,SYS_write
syscall
;恢复寄存器
pop rdx
pop rax
pop rdi
ret