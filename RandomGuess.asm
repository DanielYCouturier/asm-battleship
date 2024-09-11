INCLUDE Irvine32.inc
RandNum PROTO
.data
	moveCount BYTE ?
	difficulty DWORD ?
.code
SetDifficulty PROC
mov moveCount, 0
mov difficulty, eax
ret
SetDifficulty ENDP

RandomGuess PROC
.IF moveCount == 83 ;if all incorrect guesses are guessed
	call GuessCorrectly
	ret
.ENDIF
;eax board ptr
push ebx
mov ebx, 100
call RandNum
.IF ebx < difficulty
call GuessCorrectly
.ELSE
call GuessIncorrectly
push eax
movzx eax, moveCount
inc eax
mov moveCount, al
pop eax
.ENDIF
pop ebx
ret
RandomGuess ENDP

GuessCorrectly PROC
;eax board ptr
push edx
push ebx
push eax

rg_beg:
pop eax
push eax
mov ebx, 100
call RandNum
add eax, ebx
movzx edx, BYTE PTR[eax]
.IF dx >=1
	.IF dx <=5
		add dl,6
		mov BYTE PTR[eax],dl
		jmp rg_end
	.ENDIF
.ENDIF
jmp rg_beg
rg_end:

pop eax
pop ebx
pop edx
ret
GuessCorrectly ENDP

GuessIncorrectly PROC
;eax board ptr
push edx
push ebx
push eax

rg_beg:
pop eax
push eax
mov ebx, 100
call RandNum
add eax, ebx
movzx edx, BYTE PTR[eax]
.IF dx == 0
	add dl,6
	mov BYTE PTR[eax],dl
	jmp rg_end
.ELSE
	jmp rg_beg
.ENDIF

rg_end:

pop eax
pop ebx
pop edx
ret
GuessIncorrectly ENDP
END