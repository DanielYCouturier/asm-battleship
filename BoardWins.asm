INCLUDE Irvine32.inc
.code
BoardWins PROC
; eax = ptr to board
; sets eax to 0(false) any value in board equals 1-(unhit ship), else sets eax to 1(true)
push ecx
push esi

mov ecx, 100
mov esi, eax
L1:
movzx eax, BYTE ptr[esi]
.IF eax >= 1
	.IF eax <=5
		mov eax, 0
		jmp Exit_BoardWins
	.ENDIF
.ENDIF
inc esi
loop L1
mov eax, 1
Exit_BoardWins:
pop esi
pop ecx
ret
BoardWins ENDP
END