INCLUDE Irvine32.inc
GetDirection PROTO
AddTwoCoord PROTO
InBounds PROTO
PrintBoard PROTO
PrintCursors PROTO
GetKeyStroke PROTO
CalcShipCoordinates PROTO
SetCoordinates PROTO
AreValid PROTO
.data 
	ally_cursor COORD <?,?>
	ally_rot COORD <?,?>
	ally_unplaced BYTE 5,4,3,3,2 
	ally_cur_ship_len BYTE ?
	ally_offset DWORD 000a0023h
.code

Move_Ally PROC
push eax
push ebx
dec eax
mov ebx, eax
call GetDirection
mov eax, ally_cursor
call AddTwoCoord
mov ebx, eax
call InBounds
.IF ebx != -1
mov ally_cursor, ebx
.ENDIF 
pop ebx
pop eax
ret
Move_Ally ENDP

Rot_Ally PROC
push eax
push ebx
sub eax, 5
mov ebx, eax
call GetDirection
mov ally_rot, ebx
pop ebx
pop eax
ret
Rot_Ally ENDP



Confirm_Ship PROC
; eax board btr
; ecx ship length to place
; edx ship index
push ebx
push edx


push eax
mov eax, ally_cursor
mov ebx, ally_rot
call CalcShipCoordinates
mov ebx, eax
pop eax

push ebx
call AreValid
.IF ebx == -1
	mov eax, 0
	pop ebx
	jmp Confirm_Ship_Exit
.ENDIF
pop ebx
call SetCoordinates
mov eax, 1
Confirm_Ship_Exit:
pop edx
pop ebx
ret
Confirm_Ship ENDP


PlaceOne PROC
; eax = ptr to enemy board
push eax
L1:
pop eax
push ebx
mov ebx, ally_offset
push edx
mov edx, 1
call PrintBoard
pop edx
pop ebx
push eax

push eax
push ebx
push ecx
push edx
mov edx, eax
mov eax, ally_cursor
mov ebx, ally_rot
movzx ecx, ally_cur_ship_len
call CalcShipCoordinates
mov ebx, eax
mov eax, ally_offset
call PrintCursors
pop edx
pop ecx
pop ebx
pop eax
L2:

call GetKeyStroke
.if eax == -1
	jmp L2
.endif

.if eax < 5
    .if eax > 0
        call Move_Ally
    .endif
.endif
.if eax < 9
    .if eax > 4
        call Rot_Ally
    .endif
.endif
.if eax == 0
	pop eax
	push eax
	push ecx
	push edx
	mov edx, ecx
	movzx ecx, ally_cur_ship_len
    call Confirm_Ship
	pop edx
	pop ecx
	.IF eax == 1
		jmp exit_ally
	.ENDIF
.endif

jmp L1
exit_ally:

pop eax
ret
PlaceOne ENDP

InitializeAllyBoard PROC
; eax = board btr
mov	ally_cursor, 0
mov	ally_rot, 1
push eax
push ebx
push ecx
push esi
mov ecx, 5
lea esi, ally_unplaced
L1:
mov bl, [esi]
mov ally_cur_ship_len, bl
call PlaceOne
inc esi
loop L1

pop esi
pop ecx
pop ebx
pop eax
ret
InitializeAllyBoard ENDP


END