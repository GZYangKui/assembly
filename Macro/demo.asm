;
;简单宏定义及其使用
;
%macro aver 3
 mov eax,0
 ;将数组长度赋给ecx寄存器
 mov ecx,dword [%2]
 mov r12,0
 ;将数组元素起始地址放入rbx寄存器中
 lea rbx,[%1]
 loop %%sumLoop
%%sumLoop:
;循环元素并累加和到eax寄存器中
 add eax,dword [rbx+r12*4]
 ;自增r12达到自增数组下标效果
 inc r12
 ;循环sumLoop函数直达ecx中的值为0为止
 loop %%sumLoop
 cdq
 ;将eax寄存器中的累计和除以数组长度得到长度
 idiv dword [%2]
 ;将eax中的值移动到ava参数中
 mov dword [%3],eax

%endmacro

section .data
EXIT_SUCCESS equ 0
SYS_EXIT   equ 60

list1 dd 4,5,2,-3,-1
len1  dd 5
ave1  dd 0
list2 dd 2,6,3,-2,1,8,19
len2  dd 7
ave2  db 0

section .text
global _start
_start:
aver list1,len1,ave1
aver list2,len2,ave2

last:
mov rax,SYS_EXIT
mov rdi,EXIT_SUCCESS
syscall