section .data
;定义常量
EXIT_SUCCESS equ 0
SYS_EXIT     equ 60
;定义Byte(8bit)变量
bVar1     db    17
bVar2     db    9
bResult   db    0
;定义word(16bit)变量
wVar1    dw    1700
wVar2    dw    9000
wResult  dw    0
;定义Double-word(32bit)变量
dVar1    dd    17000000
dVar2    dd    9000000
dResult  dd    0
;定义quadword(64bit)变量
qVar1    dq    17000000
qVar2    dq    90000000
qResult  dq    0

section .text
global _start
_start:
mov al,byte [bVar1]
add al,byte [bVar2]
mov byte [bResult],al

last:
mov rax,SYS_EXIT
mov rdi,EXIT_SUCCESS
syscall