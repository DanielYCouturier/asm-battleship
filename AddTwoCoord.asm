INCLUDE Irvine32.inc
.code
AddTwoCoord PROC
; sets eax = eax+ebx
add ax, bx
ROR eax, 16
ROR ebx, 16
add ax, bx
ROR eax, 16
ROR ebx, 16
ret
AddTwoCoord ENDP
END