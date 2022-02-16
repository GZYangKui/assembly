;
;本程序实现输出9*9乘法表
;
section .data
 SYS_exit    equ          60
 SYS_write   equ          1
 STD_OUT     equ          1
 EXIT_SUCC   equ          0
 LF          equ          10
 NULL        equ          0
 row         dq           0
 column      dq           0
 preOutStr   dt           "*********格式化输出9*9乘法表**********",LF,NULL
 temp        db           NULL


section .bss
;保存20个字节用于后续字符串输出
outStr   resb       20

section .text
global _start
_start:
 push preOutStr
 call printStr
 rowLoop:
 inc qword [row]
 cmp qword [row],10
 jge last
 mov rdx,0
 mov qword [column],0
 colLoop:
 inc qword [column]
 cmp qword[column],10
 jge rowLoop
 mul dword [column]
 push qword [row]
 push qword [column]
 push rax
 call appendStr
 mov rax,qword [row]
 jmp colLoop

last:
 mov rax,SYS_exit
 mov rdi,EXIT_SUCC
 syscall

global appendStr
appendStr:
 push rbp
 mov rbp,rsp
 mov rbx,outStr
 ;结算结果
 mov bl,byte [rsp+24]
 add bl,48
 mov byte[temp],bl
 mov byte[outStr],bl
 mov bl,'*'
 mov byte[outStr+1],bl
 add bl,48
 mov bl,byte [rsp+16]
 mov byte[outStr+2],bl
 mov bl,'='
 mov byte[outStr+3],bl
 mov bl,byte [rsp+8]
 mov byte[outStr+4],bl
 mov bl,LF
 mov byte[outStr+5],bl
 push outStr
 call printStr
 mov rsp,rbp
 pop rbp
 ret
global printStr

;将字符串地址通过参数形式传入当前函数
printStr:
 push rbp
 mov rbp,rsp
 mov rbx,qword [rsp+16]
 mov rdx,0
 strCount:
 cmp byte [rbx],NULL
 je strCountEnd
 inc rdx
 inc rbx
 jmp strCount
 strCountEnd:
 mov rax,SYS_write
 mov rdi,STD_OUT
 mov rsi,qword [rsp+16]
 syscall
 mov rsp,rbp
 pop rbp
 ret

;将阿拉伯数字转换为一个完整的字符串
global numToAscii
numToAscii:
 push rbp
 mov rbp,rsp
 push r8
 mov r8,qword[rsp+16]
 pop r8
 mov rsp,rbp
 pop rbp
 ret