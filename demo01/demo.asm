section .data
 var   db    50
 var1  db    60

section .text
global _start
_start:
  mov rax,byte [var]
  add rax,byte [var1]

last:
 mov rax,60
 mov rdi,9
 syscall