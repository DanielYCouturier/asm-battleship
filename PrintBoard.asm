INCLUDE Irvine32.inc
GetDirection PROTO
AddTwoCoord PROTO
printChar MACRO character
INVOKE SetConsoleCursorPosition, consoleHandleOutput, temp_coord
INVOKE WriteConsole,
consoleHandleOutput,
ADDR character,
1,
ADDR bytesWritten,
0

ENDM

.data
consoleHandleOutput HANDLE 0
temp_coord COORD <?,?>
temp_str DWORD ? ; ptr
temp_len DWORD ?
bytesWritten DWORD ?
hashtag BYTE "#"
period BYTE "."
dash BYTE "-"
one BYTE "2"
two BYTE "S"
three BYTE "3"
four BYTE "4"
five BYTE "5"
ally_flag DWORD 0
ship1_sunk BYTE 0
ship2_sunk BYTE 0
ship3_sunk BYTE 0
ship4_sunk BYTE 0
ship5_sunk BYTE 0
.code

SetSunkFlags PROC
; eax = board ptr
push eax
push ebx
push ecx
push edx
mov ebx, 1
mov ship1_sunk, bl
mov ship2_sunk, bl
mov ship3_sunk, bl
mov ship4_sunk, bl
mov ship5_sunk, bl
mov ebx, 0
mov ecx, 100
L1:
movzx edx, BYTE ptr[eax]
.IF edx == 1
	mov ship1_sunk, bl
.ENDIF 
.IF edx == 2
	mov ship2_sunk, bl
.ENDIF
.IF edx == 3
	mov ship3_sunk, bl
.ENDIF
.IF edx == 4
	mov ship4_sunk, bl
.ENDIF
.IF edx == 5
	mov ship5_sunk, bl
.ENDIF
inc eax
loop L1
pop edx
pop ecx
pop ebx
pop eax
ret
SetSunkFlags ENDP

PrintHitShip PROC
; edx = value at coordinate
push edx
sub edx, 6
.IF edx == 1
	.IF ship1_sunk
		printChar one
	.ELSE
		printChar HashTag
	.ENDIF
.ENDIF
.IF edx == 2
	.IF ship2_sunk
		printChar two
	.ELSE
		printChar HashTag
	.ENDIF
.ENDIF
.IF edx == 3
	.IF ship3_sunk
		printChar three
	.ELSE
		printChar HashTag
	.ENDIF
.ENDIF
.IF edx == 4
	.IF ship4_sunk
		printChar four
	.ELSE
		printChar HashTag
	.ENDIF
.ENDIF
.IF edx == 5
	.IF ship5_sunk
		printChar five
	.ELSE
		printChar HashTag
	.ENDIF
.ENDIF
pop edx
ret
PrintHitShip ENDP
ResetCursor PROC
	mov temp_coord, 0
	push eax
	push ecx
	push edx
	INVOKE SetConsoleCursorPosition, consoleHandleOutput, temp_coord
	pop edx
	pop ecx 
	pop eax
	ret
ResetCursor ENDP
PrintRow PROC
;eax board ptr
;ebx coordinate offset
push ebx
push ecx
push edx
mov ecx, 10
L1:
push ecx
mov temp_coord, ebx
movzx edx, BYTE ptr [eax]
inc eax
push eax
push eax
mov eax, ally_flag
.IF edx == 0 ;blank
	mov  eax, white
    call SetTextColor
    printChar period
.ENDIF
.IF edx >= 1 ; unhit ship
.IF edx <=5 
	.IF eax ==1
	mov  eax, white
    call SetTextColor
	printChar hashtag
	.ELSE
	mov  eax, white
    call SetTextColor
	printChar period
	.ENDIF
.ENDIF
.ENDIF
.IF edx == 6 ; missed shot
	mov  eax, green
    call SetTextColor
	printChar hashtag
.ENDIF
.IF edx >= 7 ; hit ship
.IF edx <=11
	mov  eax, red
    call SetTextColor
	call PrintHitShip
.ENDIF
.ENDIF
pop eax
mov eax, 2 ; coordinate representing right transform by 2
call AddTwoCoord
mov ebx, eax
pop eax
pop ecx
dec ecx
cmp ecx, 0
jnz L1
pop edx
pop ecx
pop ebx
ret
PrintRow ENDP

PrintBoard PROC
Call SetSunkFlags
;eax board ptr
;ebx coordinate offset
;edx ally flag
push eax
push ebx
push ecx
push eax
mov ally_flag, edx
INVOKE GetStdHandle, STD_OUTPUT_HANDLE
mov consoleHandleOutput,eax
pop eax

mov ecx, 10
L2:
call PrintRow
push eax
mov eax, 00010000h ; coordinate representing down transform by 2
call AddTwoCoord
mov ebx, eax
pop eax

loop L2
pop ecx
pop ebx
pop eax
call ResetCursor
ret
PrintBoard ENDP

PrintDash PROC
push edx
push ecx
push ebx
push eax
INVOKE GetStdHandle, STD_OUTPUT_HANDLE
mov consoleHandleOutput,eax
pop eax
mov temp_coord, eax
push eax
printChar dash
pop eax
pop ebx
pop ecx
pop edx
call ResetCursor
ret
PrintDash  ENDP

PrintString PROC
mov temp_str, ebx
mov temp_coord, eax
mov temp_len, ecx
push edx
push ecx
push ebx
push eax
INVOKE GetStdHandle, STD_OUTPUT_HANDLE
mov consoleHandleOutput,eax
INVOKE SetConsoleCursorPosition, consoleHandleOutput, temp_coord
INVOKE WriteConsole, consoleHandleOutput, temp_str, temp_len, ADDR bytesWritten, 0 
call ResetCursor
pop eax
pop ebx
pop ecx
pop edx
ret
PrintString  ENDP

SetCursor PROC
; eax coord
push eax
INVOKE GetStdHandle, STD_OUTPUT_HANDLE
mov consoleHandleOutput,eax
pop eax
mov temp_coord, eax
INVOKE SetConsoleCursorPosition, consoleHandleOutput, temp_coord
ret
SetCursor ENDP
END