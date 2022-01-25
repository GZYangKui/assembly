section .data
;系统输入
STDIN    equ    0 ;standard input
SYS_READ equ    0
STDOUT   equ    1 ;standard output
STDERR   equ    2  ;standard error
SYS_WRITER equ  1
SYS_EXIT equ    60
LF       equ    10  ;/n
NULL     equ    0
TRUE     equ    1
FALSE    equ    0
EXIT_SUCCESS  equ    0
STR_LEN  equ    50

;输入定义提示内容
pmpt     db "Enter Text:",NULL
newLine  db LF,NULL

section .bss
chr    resb 1
inLine resb STR_LEN+2

section .text
global _start
_start:
 mov rdi,pmpt
 call printString
 mov rbx,inLine
 mov r12,0
readCharacter:
 mov rax,SYS_READ
 mov rdi,STDIN
 lea rsi,byte [chr]
 mov rdx,1
 syscall
 mov al,byte [chr]
 cmp al,LF
 je readDone
 inc r12
 cmp r12,STR_LEN ;如果chars大于最大允许字符长度,则停止放入buffer
 jae readCharacter
 mov byte [rbx],al
 inc rbx
 jmp readCharacter
readDone:
 call printString
 mov byte [rbx],NULL
 mov rdi,inLine
 call printString
last:
mov rax,SYS_EXIT
mov rdi,EXIT_SUCCESS
syscall

;定义打印函数
global printString
printString:
 push rbp
 mov rbp,rsp
 push rbx
 mov rbx,rdi
 mov rdx,0
 ;计算字符创长度
strCountLoop:
 cmp byte [rbx],NULL
 je strCountDone
 inc rdx
 inc rbx
 jmp strCountLoop
strCountDone:
 cmp rdx,0
 je prtDone
 mov rax,SYS_WRITER
 mov rsi,rdi
 mov rdi,STDOUT
 syscall
prtDone:
 pop rbx
 pop rbp
 ret