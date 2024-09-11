INCLUDE Irvine32.inc
PrintDash PROTO
InBounds PROTO
AreValid PROTO
CalcOffset PROTO
.code
PrintCursor PROC
; eax contains board coordinate offset
; ebx contains cursor postion
; edx contains lea board
push edx
push eax
push ebx
push eax

push ebx
call CalcOffset
add edx, ebx
pop ebx
movzx eax, BYTE ptr [edx]
.IF eax == 0
	mov  eax, white
    call SetTextColor
.ENDIF
.IF eax >=1
.IF eax <=5
	mov  eax, white
    call SetTextColor
.ENDIF
.ENDIF
.IF eax == 6
	mov  eax, green
    call SetTextColor
.ENDIF
.IF eax >= 7
.IF eax <= 11
	mov  eax, red
    call SetTextColor
.ENDIF
.ENDIF



mov eax,2
mul bx
ROR eax, 16
ROR ebx, 16
mov ax, bx
ROR eax, 16
ROR ebx, 16

pop ebx 
add eax, ebx
call PrintDash
pop ebx
pop eax
pop edx
ret
PrintCursor ENDP
PrintGuessCursor PROC

push edx
push eax
push ebx
push eax

push ebx
call CalcOffset
add edx, ebx
pop ebx

mov eax,2
mul bx
ROR eax, 16
ROR ebx, 16
mov ax, bx
ROR eax, 16
ROR ebx, 16

pop ebx 
add eax, ebx
call PrintDash
pop ebx
pop eax
pop edx
ret
PrintGuessCursor ENDP
PrintCursors PROC
; eax contains board coordinate offset
; ebx contains cursor array ptr
; ecx = ship length
; edx = lea board
push ebx
push esi
push ecx


push eax
push ebx
mov eax, edx
call AreValid
.IF ebx == -1
	mov  eax, red
    call SetTextColor
.ENDIF
pop ebx
pop eax


mov esi, ebx
L2:
mov ebx, [esi]
call InBounds
.IF ebx != -1
	call PrintGuessCursor
.ENDIF
add esi, 4
loop L2
pop ecx
pop esi
pop ebx
ret
PrintCursors ENDP
END