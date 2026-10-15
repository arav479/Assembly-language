; PROGRAM: CONVERT A HEXADECIMAL NUMBER TO DECIMAL AND PRINT IT
CR      EQU 0DH
LF      EQU 0AH

data segment
	hexnum dw 1A2FH                ; hexadecimal number (change this)
	msg    db "DECIMAL VALUE = $"
	crlf   db CR, LF, '$'
data ends

code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax

	mov ah,09h
	lea dx,msg
	int 21h                    ; print "DECIMAL VALUE = "

	mov ax,hexnum              ; AX = 1A2FH (stored as binary)
	mov bx,10                  ; divisor
	mov cx,0                   ; digit counter

divloop:
	mov dx,0                   ; DX:AX / 10
	div bx                     ; AX = quotient, DX = remainder (a digit)
	push dx                    ; save digit (they come out in reverse)
	inc cx
	cmp ax,0
	jne divloop                ; repeat until quotient is 0

printloop:
	pop dx                     ; digits come out in correct order
	add dl,30h                 ; digit -> ASCII character
	mov ah,02h
	int 21h
	loop printloop             ; print CX digits

	mov ah,09h
	lea dx,crlf                ; new line
	int 21h

	mov ah,4ch
	int 21h
code ends
end start