INCLUDE Irvine32.inc
.code
CalcOffset PROC
; changes ebx = COORD<x,y> to 2d index of coord in 1d array
push eax
push edx
ROR ebx, 16
mov ax, 10
mul bx
ROR ebx, 16
add ax, bx
and eax, 0FFFFh
mov ebx, eax
pop edx
pop eax
ret
CalcOffset ENDP


SetCoordinate PROC 
; eax board ptr
; ebx coordinate
; edx value
push eax
INVOKE CalcOffset
add eax, ebx
mov BYTE ptr [eax], dl

pop eax
ret
SetCoordinate ENDP

SetCoordinates PROC 
; eax board ptr
; ebx coordinates ptr
; ecx coordinates len
; edx value
push esi
push ebx
push ecx
mov esi, ebx
L1:
mov ebx, [esi]
INVOKE SetCoordinate
add esi, 4
loop L1
pop ecx
pop ebx
pop esi
ret
SetCoordinates ENDP
END