INCLUDE Irvine32.inc
GetDirection PROTO
CalcShipCoordinates PROTO
RandNum PROTO
SetCoordinates PROTO
AreValid PROTO
.data
	boardptr DWORD ?
	unplaced BYTE 5,4,3,3,2 
	start COORD <?,?>
	dir COORD <?,?>
.code
InitializeEnemyBoard PROC
push ebx
push ecx
push edx
push esi
mov boardptr, eax
lea esi, unplaced
mov ecx, 5
L1:
	mov ebx, 10
	call RandNum
	mov start.X, bx 
	mov ebx, 10
	call RandNum
	mov start.Y, bx
	mov ebx, 4
	call RandNum
	call GetDirection
	mov dir, ebx
	;;;;;;;;;;;;;;;;;; .data segment initialzed
	mov eax, start
	push ecx
	movzx ecx, byte ptr [esi]
	call CalcShipCoordinates ; eax contains ptr to new_ship
	push eax
	mov ebx, eax
	mov eax, boardptr
	call AreValid 
	;repeat everything dont increment
	.IF ebx == -1
		pop ecx
		pop ecx
		jmp L1
	.ENDIF
	pop ebx
	pop edx
	call SetCoordinates
	mov ecx, edx


inc esi
loop L1

pop esi
pop edx
pop ecx
pop ebx
ret
InitializeEnemyBoard ENDP
END