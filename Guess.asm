INCLUDE Irvine32.inc
GetKeyStroke PROTO
GetDirection PROTO
AddTwoCoord PROTO
InBounds PROTO
CalcOffset PROTO
PrintBoard PROTO
PrintCursor PROTO
.data 
	enemy_offset DWORD 000a0041h
	guess_cursor COORD <0,0>
.code

Move_Guess PROC
push eax
push ebx
dec eax
mov ebx, eax
call GetDirection
mov eax, guess_cursor
call AddTwoCoord
mov ebx, eax
call InBounds
.IF ebx != -1
mov guess_cursor, ebx
.ENDIF 
pop ebx
pop eax
ret
Move_Guess ENDP

Confirm_Guess PROC
push ebx
push edx

mov ebx, guess_cursor
call CalcOffset
add eax, ebx
mov dl, BYTE ptr [eax]
.IF dl < 6
	add dl, 6
	mov BYTE ptr [eax], dl
	mov eax, 1
.ELSE
	mov eax, 0
.ENDIF

pop edx
pop ebx
ret
Confirm_Guess ENDP



Guess PROC
; eax = ptr to enemy board
push eax

L1:
pop eax
push ebx
mov ebx, enemy_offset
push edx
mov edx, 0
call PrintBoard
pop edx
pop ebx
push eax

push eax
push ebx
push edx
mov edx, eax
mov eax, enemy_offset
mov ebx, guess_cursor
call PrintCursor
pop edx
pop ebx
pop eax
L2:

call GetKeyStroke
.if eax == -1
	jmp L2
.endif

.if eax < 5
    .if eax > 0
        call Move_Guess
    .endif
.endif
.if eax == 0
	pop eax
	push eax
    call Confirm_Guess
	.IF eax == 1
		jmp exit_guess
	.ENDIF
.endif
jmp L1
exit_guess:

pop eax
ret
Guess ENDP
ResetGuess PROC
mov guess_cursor, 0
ret
ResetGuess ENDP
END