INCLUDE Irvine32.inc
CalcOffset PROTO
.code
InBounds PROC
; ebx = some coordinate
; sets ebx to -1 if ebx is out of board bounds
.IF ebx == 0
    ret
.ENDIF
.IF bx < 0
    mov ebx, -1
    ret
.ENDIF
.IF bx > 9
    mov ebx, -1
    ret
.ENDIF
ROR ebx, 16
.IF bx < 0
    mov ebx, -1
    ret
.ENDIF
.IF bx > 9
    mov ebx, -1
    ret
.ENDIF
ROR ebx, 16
ret
InBounds ENDP 


IsValid PROC ; returns 1 or -1
; eax = ptr to board
; ebx = coordinate
call InBounds
.IF ebx == -1
    ret
.ENDIF
push eax
call CalcOffset
add eax, ebx
mov bl, [eax]
pop eax
.IF ebx == 0
    mov ebx, 1
.ELSE
	mov ebx, -1
.ENDIF
ret
IsValid ENDP 

AreValid PROC 
; eax board ptr
; ebx coordinates ptr
; ecx coordinates len
; returns ebx = -1 for false, ebx = 1 for true
push esi
push ecx
mov esi, ebx
L1:
mov ebx, [esi]
call IsValid
.IF ebx == -1
    jmp exit1
.ENDIF
add esi, 4
loop L1
mov ebx, 1

exit1:
pop ecx
pop esi
ret
AreValid ENDP
END