INCLUDE Irvine32.inc
.data 
	up COORD <0,-1> ;0
	down COORD <0,1> ;1
	left COORD <-1,0> ;2
	right COORD <1,0> ;3
.code
; ebx = 1-4
; sets ebx = .data[ebx] else 0
GetDirection PROC
.IF ebx == 0
    mov ebx, up
    ret
.ENDIF
.IF ebx == 1
    mov ebx, down
    ret
.ENDIF
.IF ebx == 2
    mov ebx, left
    ret
.ENDIF
.IF ebx == 3
    mov ebx, right
    ret
.ENDIF
mov ebx, 0
ret
GetDirection ENDP
END