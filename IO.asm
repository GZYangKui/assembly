section .data
LF              equ            10
NULL            equ             0
SYS_write       equ             1
SYS_OUT         equ             1

section .bss
strBuff         resb         11
strBuff1        resb         11

section .text

;
;
;将数字转换为字符串并输出
;
;
global print_num
print_num:
push rbp
push rbx
mov rbp,rsp
mov r8,0
;被除数
mov rax,qword[rbp+24]
leftLoop:
cdq
;除数
mov rbx,10
idiv rbx
mov bl,dl
add bl,48
mov byte[strBuff+r8],bl
inc r8
cmp rax,0
jne leftLoop
mov r9,0
mov r10,r8
reviseBuff:
mov bl,byte[strBuff+r8-1]
mov byte[strBuff1+r9],bl
dec r8
inc r9
cmp r9,r10
jbe reviseBuff
mov byte[strBuff1+r10],LF
mov byte[strBuff1+r10+1],NULL
mov rsi,strBuff1
call print_text
pop rbx
pop rbp
ret
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