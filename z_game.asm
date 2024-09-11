INCLUDE Irvine32.inc
PrintBoard PROTO
InitializeEnemyBoard PROTO
InitializeAllyBoard PROTO
BoardWins PROTO
Guess PROTO
RandomGuess PROTO
GetKeyStroke PROTO
PrintString PROTO
ResetGame PROTO
ResetGuess PROTO
SetDifficulty PROTO

printStr MACRO string, pos
mov eax, pos
lea ebx, string
mov ecx, LENGTHOF string
call PrintString
ENDM

.data
	enemyboard BYTE 10 dup(10 dup(0))
	allyboard BYTE 10 dup(10 dup(0))
	info0 BYTE "------------------------------"
	info1 BYTE "|         BATTLESHIP         |"
	info2 BYTE "| CONTROLS:                  |"
	info3 BYTE "| ARROW KEYS = MOVE          |"
	info4 BYTE "| WASD = ROTATE SHIP         |"
	info5 BYTE "| ENTER = CONFIRM PLACEMENT  |"
	info6 BYTE "| Q or E = EXIT              |"
	background_int BYTE "*                   *"
	background_ext BYTE "*********************"
	win_msg BYTE "YOU WIN"
	lose_msg BYTE "YOU LOSE"
	exit_msg BYTE "PRESS R TO PLAY AGAIN"
	msg_erase BYTE 8 DUP(" ")
	exit_erase BYTE 21 DUP(" ")
.code
GameMain PROC
call SetDifficulty
push eax
push ebx
push ecx
push edx
call Initialize
L1:
	lea eax, enemyboard
	call Guess
	push eax
	call BoardWins
	.IF eax == 1
		pop eax
		jmp exit_win
	.ENDIF
	pop eax

	lea eax, allyboard
	call RandomGuess
	mov ebx, 000a0023h
	mov edx, 1
	call PrintBoard
	push eax
	call BoardWins
	.IF eax == 1
		pop eax
		jmp exit_lose
	.ENDIF
	pop eax
jmp L1

exit_win:
lea eax, allyboard
mov ebx, 000a0023h
mov edx, 1
call PrintBoard
mov  eax, white
call SetTextColor
printStr win_msg, 00160038h
printStr exit_msg, 00170032h
lea eax, enemyboard
mov ebx, 000a0041h
mov edx, 0
call PrintBoard
jmp exit_main

exit_lose:
mov  eax, white
call SetTextColor
printStr lose_msg, 00160038h
printStr exit_msg, 00170032h
lea eax, enemyboard
mov ebx, 000a0041h
mov edx, 0
call PrintBoard
jmp exit_main


exit_main:
call GetKeyStroke
.IF eax == 9
	jmp real_exit
.ENDIF
jmp exit_main
real_exit:
pop edx
pop ecx
pop ebx
pop eax
call ResetGame
call ResetGuess
ret
GameMain ENDP


Initialize PROC
push eax
push ebx
push ecx
push edx
mov  eax, white
call SetTextColor
printStr msg_erase, 00160038h
printStr exit_erase, 00170032h
printStr info0, 0000002dh
printStr info1, 0001002dh
printStr info2, 0002002dh
printStr info3, 0003002dh
printStr info4, 0004002dh
printStr info5, 0005002dh
printStr info6, 0006002dh
printStr info0, 0007002dh

printStr background_ext, 00090022h
printStr background_int, 000a0022h
printStr background_int, 000b0022h
printStr background_int, 000c0022h
printStr background_int, 000d0022h
printStr background_int, 000e0022h
printStr background_int, 000f0022h
printStr background_int, 00100022h
printStr background_int, 00110022h
printStr background_int, 00120022h
printStr background_int, 00130022h
printStr background_ext, 00140022h


printStr background_ext, 00090040h
printStr background_int, 000a0040h
printStr background_int, 000b0040h
printStr background_int, 000c0040h
printStr background_int, 000d0040h
printStr background_int, 000e0040h
printStr background_int, 000f0040h
printStr background_int, 00100040h
printStr background_int, 00110040h
printStr background_int, 00120040h
printStr background_int, 00130040h
printStr background_ext, 00140040h
lea eax, enemyboard
call InitializeEnemyBoard
mov ebx, 000a0041h
mov edx, 0
call PrintBoard


lea eax, allyboard
call InitializeAllyBoard
mov ebx, 000a0023h
mov edx, 1
call PrintBoard

pop edx
pop ecx
pop ebx
pop eax
ret
Initialize ENDP
ResetGame PROC
push eax
push ecx
push edi

cld
lea edi, enemyboard
mov eax, 0
mov ecx, 100
rep stosb
cld
lea edi, allyboard
mov eax, 0
mov ecx, 100
rep stosb

pop edi
pop ecx
pop eax
ret
ResetGame ENDP
END