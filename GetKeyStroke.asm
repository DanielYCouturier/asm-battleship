INCLUDE Irvine32.inc
.code
GetKeyStroke PROC
push ebx
push edx
; eax gets changed to key = value:
;q / e = TERMINATE PROGRAM
;enter = 0
;up  = 1
;down = 2
;left = 3
;right = 4 
;w = 5
;s = 6
;a = 7
;d = 8
null = -1
mov eax, 50
call Delay
call ReadKey ;readkey changes alot of registers
.IF dx == 0051h
    INVOKE ExitProcess, 0
.ENDIF
.IF dx == 0045h
    INVOKE ExitProcess, 0
.ENDIF
.IF dx == 000dh
    mov eax, 0
    jmp exit_proc
.ENDIF
.IF dx == 0026h
    mov eax, 1
    jmp exit_proc
.ENDIF
.IF dx == 0028h
    mov eax, 2
    jmp exit_proc
.ENDIF
.IF dx == 0025h
    mov eax, 3
    jmp exit_proc
.ENDIF
.IF dx == 0027h
    mov eax, 4
    jmp exit_proc
.ENDIF

.IF dx == 0057h
    mov eax, 5
    jmp exit_proc
.ENDIF
.IF dx == 0053h
    mov eax, 6
    jmp exit_proc
.ENDIF
.IF dx == 0041h
    mov eax, 7
    jmp exit_proc
.ENDIF
.IF dx == 0044h
    mov eax, 8
    jmp exit_proc
.ENDIF
.IF dx == 0052h
    mov eax, 9
    jmp exit_proc
.ENDIF
mov eax, -1
exit_proc:
pop edx
pop ebx
ret
GetKeyStroke ENDP
END