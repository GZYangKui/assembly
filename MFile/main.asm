section .data
;定义常量
LF             equ       10
NULL           equ        0
TRUE           equ        1
FALSE          equ        0
EXIT_SUCCESS   equ        0
SYS_exit       equ        60
;定义数据
lst1            dd         1,-2,3,-4,5
                dd         7,9,11
len1            dd         8
lst2            dd         2,-3,4,-5,6
                dd         -7,10,12,14,16
len2            dd         10


section .bss
sum1        resb      1
ave1        resb      1
sum2        resb      1
ave2        resb      1

;---------------------------------------------
extern      stats

section .text
global _start
_start:
mov rdi,lst1
mov esi,dword [len1]
mov rdx,sum1
mov rcx,ave1
call stats

mov rdi,lst2
mov esi,dword [len2]
mov rdx,sum2
mov rcx,ave2
call stats

last:
mov rax,SYS_exit
mov rdi, EXIT_SUCCESS
syscall