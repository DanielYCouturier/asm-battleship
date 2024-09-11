INCLUDE Irvine32.inc
GameMain PROTO
PrintString PROTO
SetCursor PROTO
printStr MACRO string, pos
mov eax, pos
lea ebx, string
mov ecx, LENGTHOF string
call PrintString
ENDM

; source https://ascii.co.uk/art/battleship
; (im not that talented)

.data 
T1 BYTE "8888PYba,                              88                      88          88  8b,dPPYba, " 
T2 BYTE "88     '8a               ,d      ,d    88                      88          ''  88P'    '8a" 
T3 BYTE "88      d8               88      88    88                      88              88       d8"
T4 BYTE "888dPPYbP   ,adPPYYba, MM88MMM MM88MMM 88  ,adPPYba, ,adPPYba, 88,dPPYba,  88  88b,   ,a8'"
T5 BYTE "88      '8a ''     'Y8   88      88    88 a8P_____88 I8[    '' 88P'    '8a 88  88'YbbdP'' "
T6 BYTE "88       d8 ,adPPPPP88   88      88    88 8PP'''''''  ''Y8ba,  88       88 88  88         "
T7 BYTE "88     ,a8' 88,    ,88   88,     88,   88 '8b,   ,aa aa    ]8I 88       88 88  88         "
T8 BYTE "8Y'Ybbd8''  ''8bbdP'Y8   'Y888   'Y888 88  ''Ybbd8'' ''YbbdP'' 88       88 88  88         "

S1 BYTE "                                     # #  ( )                        "
S2 BYTE "                                  ___#_#___|__                       "
S3 BYTE "                              _  |____________|  _                   "
S4 BYTE "                       _=====| | |            | | |==== _            "
S5 BYTE "                 =====| |.---------------------------. | |====       "
S6 BYTE "   <--------------------'   .  .  .  .  .  .  .  .   '--------------/"
S7 BYTE "     \                                                             / "
S8 BYTE "      \___________________________________________________________/  "
message BYTE "Enter a Difficulty 1-100: "
errormsg BYTE "INVALID VALUE, TRY AGAIN"
erase BYTE 120 DUP (" ")

.code
EraseScreen PROC
printStr erase, 00000000h
printStr erase, 00010000h
printStr erase, 00020000h
printStr erase, 00030000h
printStr erase, 00040000h
printStr erase, 00050000h
printStr erase, 00060000h
printStr erase, 00070000h
printStr erase, 00080000h
printStr erase, 00090000h
printStr erase, 000a0000h
printStr erase, 000b0000h
printStr erase, 000c0000h
printStr erase, 000d0000h
printStr erase, 000e0000h
printStr erase, 000f0000h
printStr erase, 00100000h
printStr erase, 00110000h
printStr erase, 00120000h
printStr erase, 00130000h
printStr erase, 00140000h
printStr erase, 00150000h
printStr erase, 00160000h
printStr erase, 00170000h
printStr erase, 00180000h
printStr erase, 00190000h
printStr erase, 001b002dh
printStr erase, 001c0000h
printStr erase, 001d0000h
printStr erase, 001e0000h
ret
EraseScreen ENDP
main PROC
L1:
mov  eax, red
call SetTextColor
printStr T1, 00020010h
printStr T2, 00030010h
printStr T3, 00040010h
printStr T4, 00050010h
printStr T5, 00060010h
printStr T6, 00070010h
printStr T7, 00080010h
printStr T8, 00090010h
mov  eax, white
call SetTextColor
printStr S1, 00120015h
printStr S2, 00130015h
printStr S3, 00140015h
printStr S4, 00150015h
printStr S5, 00160015h
printStr S6, 00170015h
printStr S7, 00180015h
printStr S8, 00190015h
L2:
printStr erase, 001b0000h
printStr message, 001b002dh
mov eax,001b0047h
call SetCursor
call ReadInt
.IF eax <=100
.IF eax >= 1
push eax
jmp exit_L2
.ENDIF
.ENDIF
printStr erase, 001c0000h
printStr errormsg, 001c002dh
jmp L2
exit_L2:
call EraseScreen
pop eax
call GameMain
call EraseScreen
jmp L1
INVOKE ExitProcess, 0
main ENDP
END main