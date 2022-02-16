section .text
global stats
stats:
push r12
mov r11,0
mov r12d,0

sumLoop:
mov eax,dword[rdi+r11*4]
add r12d,eax
inc r11
cmp r11,rsi
;条件满足跳转
jb sumLoop
mov dword[rdx],r12d

;--------------
;Find and return average.
mov eax,r12d
cdq
idiv esi
mov dword[rcx],eax

pop r12
ret