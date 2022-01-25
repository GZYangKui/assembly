section .data
EXIT_SUCCESS  equ    0
LF            equ    10
NULL          equ    0
TRUE          equ    1
FALSE         equ    0
STDIN         equ    0 ;标准输入
STDOUT        equ    1 ;标准输出
STDERR        equ    2 ;标准错误

;系统调用号
SYS_exit      equ    60  ;程序终止
SYS_read      equ    0
SYS_write     equ    1
SYS_open      equ    2   ;打开文件
SYS_close     equ    3   ;文件关闭
SYS_fork      equ    57  ;fork进程
SYS_create    equ    85  ;文件创建/打开
SYS_time      equ    201 ;系统时间

O_CREATE      equ    0x40
O_TRUE        equ    0x200
O_APPEND      equ    0x400

O_RDONLY      equ    00000q ;仅读
O_WRONLY      equ    00001q ;仅写
O_REWR        equ    00002q ;读写

S_IRUSR      equ     00400q
S_IWUSR      equ     00200q
S_IXUSR      equ     00100q

newLine      db     LF,NULL
header       db     LF,"File Write Example.",LF,NULL
fileName     db     "test.txt",NULL
url          db     "https://baidu.com"
             db     LF,NULL
len          db     $-url-1
writeDone    db     "Write Completed.",LF,NULL
fileDesc     dq     0
errMsgOpen   db     "Error opening file.",LF,NULL
errMsgWrite  db     "Error writing to file",LF,NULL
debugStr     db     "Test output......",LF,NULL
debugStrLen  dq     0

section .bss
;用于缓存数字到字符转换结果
buffer       resd         2

section .text

global _start
_start:
 openInputFile:
  lea rdi,byte [debugStr]
  call printString
  mov rax,SYS_create
  mov rdi,fileName
  mov rsi,S_IRUSR | S_IWUSR
  syscall
  cmp rax,0       ;检查文件打开是否成功
  jl  errorOpen
  mov qword [fileDesc],rax  ;保存文件描述符号
  mov rax,SYS_write
  lea rsi,byte [url]
  mov rdx,qword [len]
  mov rdi,qword [fileDesc]
  syscall
  ;判断写入是否成功
  cmp rax,0
  jl errorWrite
  mov rdi,writeDone
  call printString


last:
 mov rax,SYS_exit
 mov rdi,EXIT_SUCCESS
 syscall

errorOpen:
mov rdi,debugStr
call printString
mov rdi,errMsgOpen
call printString
jmp last

errorWrite:
mov rdi,errMsgWrite
;文件写入失败
call printString
jmp last

global printString ;打印字符串函数
printString:
 push rbp
 mov rdx,0
 mov rbp,rsp
countStrLen:  ;计算字符串长度
 cmp byte[rdi+rdx],NULL ;判断是否到达字符串末尾,如果到达字符串末尾则跳出当前循环
 je countStrEnd
 inc rdx
 jmp countStrLen

 countStrEnd:
 mov rsi,rdi
 mov rax,SYS_write
 mov rdi,STDOUT
 mov qword [debugStrLen],rdx
 syscall
 pop rbp
 ret