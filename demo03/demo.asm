.code32
.section .data
 .equ LINUX_SYSCALL,0x80

.section .bss
 .equ BUFFER_SIZE,500
 .lcomm BUFFER_DATA,BUFFER_SIZE

.section .text
.global _start
_start:
 pushl $1
 pushl $2
 call add_func
 movl $0,%ebx
 int $LINUX_SYSCALL

.type add_func,@function
add_func:
 pushl %ebp
 movl %esp,%ebp
# 向外扩展一个字用于存储计算结果
 subl $4,%esp
 movl 8(%ebp),%eax
 movl 12(%ebp),%ecx
 addl %ebx,%ecx
 movl %ecx,-4(%ebp)
 popl %ebp
 ret
