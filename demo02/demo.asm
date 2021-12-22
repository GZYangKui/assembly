#
# 1、计算机的栈处于内存地址的最顶端。
# 2、无论栈顶在哪里,栈寄存器[%esp]总是包含一个指向当前栈顶的指针。
# 3、push1是要将其值入栈的寄存器
# 4、pop1是要接收弹出栈数据的寄存器
# 5、call指令会做两件事：它将下一条指令的地址即返回地址压入栈中；然后修改指令指针(%eip)以指向函数起始处。
# 6、基址指针(%ebp)是一个特殊的寄存器，用于访问函数的参数与局部变量,其恒指向栈指针(%esp)起始位置,在当前栈中可视为常量。
# 7、ret指令将栈顶值弹出并将指令指针寄存器%eip设置为该弹出值。
#
.code32 # 告诉as按照32位系统编译
.section .data
.section .text
.global _start
_start:
 #将函数所有参数逆序压入栈
 pushl $3 #压入第二个参数
 pushl $2 #压入第一个参数
 #将下一条指令及返回地址压入栈中,修改指令指针指向函数起始处
 call power  #调用函数
 addl $8,%esp #将栈指针向后移动
 pushl %eax #在调用下一个函数之前,保存之前的答案
 pushl $2
 pushl $5
 call power
 addl $8,%esp
 popl %ebx
 addl %eax,%ebx
 movl $1,%eax
 int $0x80

 .type power, @function
power:
 pushl %ebp #保存当前基址指针
 movl %esp,%ebp #将基址指针指向当前栈指针地址
 subl $4,%esp #向外扩展一个字大小的内存用于存储计算结果
 movl 8(%ebp),%ebx #将第一个参数放入%ebx
 movl 12(%ebp),%ecx #将第二个参数放入%ecx
 movl %eax,-4(%ebp)  #存储当前结果
power_loop_start:
 cmpl $1,%ecx  #如果是1次幂
 je end_power  #直接跳转到end_power
 movl -4(%ebp),%eax #将当前结果移入%eax
 imull %ebx,%eax #将当前结果与指数相乘
 movl %eax,-4(%ebp) #保存当前结果
 decl %ecx #指数递减
 jmp power_loop_start #跳转到循环开始处
end_power:
 movl -4(%ebp),%eax #返回值移入%eax
 movl %ebp,%esp  #将基址指针移入栈指针(恢复栈指针)
 popl %ebp #使用基址寄存器存储弹出值(恢复基址指针)
 ret #执行ret指令
