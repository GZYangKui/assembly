# ASM function use register give the inut data
.section .data
	str:.ascii "ASM THIRD DAY\n"
	sl=.-str

.section .text
.global _start
_start:
	movl $0, %eax		# Init eax
	movl $2, %ebx		# Prepare data in ebx first

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
	add %ebx, 	%ebx
	movl %ebx, 	%eax
ret