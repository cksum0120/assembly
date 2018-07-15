section .data
message: db "insert num(1~9) :",15,0
nop : db "nop",0
star : dw 0x2a,0
enter : dw 0x0a,0

section .bss
input resb 4

section .text

global _start

;r8 i, r9 j
_pstar:
	push rbp
	mov rbp,rsp
	mov r8,0
	mov rbx,[rsp+16]
	l1:
		inc r8
		mov r9,0
		l2:
			;print star
			inc r9
			mov rax,1
			mov rdi,1
			mov rsi,star
			mov rdx,2
			syscall
			cmp r9,r8
			jl l2

		;print line feed
		mov rax,1
		mov rdi,1
		mov rsi,enter
		mov rdx,2
		syscall	
		cmp r8,rbx
		jl l1

	leave
	ret


_start:
	push rbp
	mov rbp,rsp

	mov rax,1
	mov rdi,1
	mov rsi,message
	mov rdx,17
	syscall

	mov rax,0
	mov rdi,0
	mov rsi,input
	mov rdx,2
	syscall

	mov rdx,0
	mov rbx,2
	mov rsi,[input]
	sub rsi,0xa30
	mov rax,rsi
	push rsi ; save the number

	div rbx
	cmp rdx,0
	je _exit

	call _pstar

	mov rax,60
	xor rdi,rdi
	syscall

_exit:
	push rbp
	mov rbp,rsp
	mov rax,60
	xor rdi,rdi
	syscall
