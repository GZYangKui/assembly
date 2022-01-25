       section .data
        SYS_exit       equ     60
        EXIT_SUCCESS   equ     0
        a              dq      0
        b              dq      0
        sum            dq      0

       section .text
       global _start
       _start:
        ;按照c/c++语言调用约定入栈参数
        push b
        push a
        call sum_func

       last:
        mov rax,SYS_exit
        mov rdi,EXIT_SUCCESS
        syscall
       ;函数实现sum=a+b功能
       global sum_func
       sum_func:
        push rbp
        mov rbp,rsp
        mov rax,qword [a]
        add rax,qword [b]
        mov rsp,rbp
        pop rbp
        ret