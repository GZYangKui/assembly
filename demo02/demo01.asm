# ASM function use register give the inut data
.code32
.section .data
	str:.ascii "ASM THIRD DAY\n"
	sl=.-str

.section .text
.global _start
_start:
	pushl $1  #入栈第二个参数
	pushl $5  #入栈第一个参数

	call add_func		# Then call child function

	movl $1,%ebx
	movl $str,%ecx
	movl $sl,%edx

	int $0x80

	movl $1,%eax

	# System call: exit
	movl $0,%ebx
	int $0x80

# The method of GNU define a function
.type add_func, @function
add_func:
	pushl %ebp
	movl %esp,%ebp
	 #向外扩展一个字用于存储计算结果
	subl $4,%esp
	movl 8(%ebp),%eax
	movl 12(%ebp),%ecx
	addl %ebx,%ecx
	movl %ecx,-4(%ebp)
	popl %ebp
ret