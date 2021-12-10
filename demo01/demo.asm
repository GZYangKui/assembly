#
# 从data_items数组中查询最大值
#
#
.section .data
data_items:          #数据项
.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0
.section .text
.global _start
_start:
movl $0,%edi  #将零移入索引寄存器
movl data_items(,%edi,4),%eax #加载数据第一个字节,其中的4表示long数据类型的长度4个字节
movl %eax,%ebx  #由于第一项项目所以%eax是最大值
start_loop:  #开始循环
cmpl $0,%eax  #判断是否到达末尾
je loop_exit #该条指令表示上述比较成立则执行该指令.该条指令中(e代表equal)
incl %edi
movl data_items(,%edi,4),%eax
cmpl %eax,%ebx   #比较值
jle start_loop   #若新项不大于原最大值则跳到循环起始处
movl %eax,%ebx  #将eax移到%ebx作为最新最大值
jmp start_loop  #跳到循环起始处
loop_exit:
movl $1,%eax #1是exit()系统调用
int $0x80 #中断程序,将控制权交给系统
