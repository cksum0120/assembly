section .data
int_fmt : db "%d", 0
str_fmt : db "%s",10, 0
lq_fmt : db "%d * %d = %d",10,0
cr : db 10, 0
welcome : db "welcome ~ select 1 or 2",0
enternum : db "enter number : "

section .bss
num : resb 1

section .text

extern printf
extern exit
extern scanf

global main,_start

lqdan: ; r10 = i, r11 = j
	push rbp
	mov rbp,rsp
	mov r10,0 ; i
	mov r11,0 ; j
	l1:
		inc r10
		cmp r10,20
		je _start
		mov r11,0
		mov rax,0

		l2:
			inc r11
			cmp r11,10
			je l1

			mov rax,r10
			mul r11
 		
 			push r10
 			push r11

			mov rdi,lq_fmt
			mov rsi,r10
			mov rdx,r11
			mov rcx,rax
 			call printf

 			pop r11
 			pop r10

 			jmp l2



Ndan:
	push rbp
	mov rbp, rsp

	mov rsi, enternum 
 	mov rax, 0
	mov rdi, str_fmt
	call printf

	mov rsi, num
	mov rdi, int_fmt
 	mov rax, 0
 	call scanf

	mov r10,[num]
	mov r11,0
	
	l3:
		inc r11
		cmp r11,10
		je _start
		mov rax,r10
		mul r11

		push r10
		push r11
 	
		mov rdi,lq_fmt
		mov rsi,r10
		mov rdx,r11
		mov rcx,rax
		call printf

		pop r11
		pop r10

		jmp l3

	leave
	ret

main:
 _start:
 		push rbp
 		mov rbp,rsp

 		mov rsi, welcome
 		mov rax, 0
 		mov rdi, str_fmt
 		call printf

 		mov rsi, num
 		mov rdi, int_fmt
 		mov rax, 0
 		call scanf

 		mov r8,[num]
 		
 		cmp r8,1
 		je lqdan

 		cmp r8,2
 		je Ndan

 		call exit