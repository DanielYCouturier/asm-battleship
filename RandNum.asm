INCLUDE Irvine32.inc
.code
RandNum PROC ; Irvines is same value every time, bug or feature im not sure but:
; input ebx = maxval
; ebx = rand(ebx)
	push eax
	push edx
	
	; "random" function = ((processor clock cycles since reboot) mod ebx) because i couldnt find a syscall for time in masm 
	RDTSC 
	xor edx, edx ; needs to be set to 0 
	div ebx 
	mov ebx, edx

	pop edx
	pop eax
	ret
RandNum ENDP
END