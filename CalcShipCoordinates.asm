INCLUDE Irvine32.inc
AddTwoCoord PROTO
.data
	newship DWORD 5 dup(?)
.code
; eax = startcoord
; ebx = dircoord
; ecx = ship_size<=5
; newship = first ecx# of DWORDS in newship are set to coordinates of a ship defined by eax,ebx,ecx
; sets eax = lea newship
CalcShipCoordinates PROC
push esi
push ecx
mov esi, OFFSET newship
L1:
mov [esi], eax
call AddTwoCoord 
add esi, 4
loop L1
pop ecx
pop esi
lea eax, newship
ret
CalcShipCoordinates ENDP
END