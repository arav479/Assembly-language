; PROGRAM: FIND THE SUM OF 5 NUMBERS AND PRINT IT
data segment
	arr db 10,20,30,40,50          ; the 5 numbers (1 byte each)
	n   equ 5                      ; how many numbers
	msg db "SUM = $"
data ends

code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax

	lea si,arr                 ; SI -> first number
	mov cx,n                   ; loop counter = 5
	mov ax,0                   ; AX holds the running sum (16-bit)

again:
	mov bl,[si]                ; BL = current number
	mov bh,0                   ; BX = number as a 16-bit value
	add ax,bx                  ; sum = sum + number
	inc si                     ; next number
	loop again                 ; CX = CX-1, repeat until CX = 0

	push ax                    ; save sum (AH is overwritten by printing)
	mov ah,09h
	lea dx,msg
	int 21h                    ; print "SUM = "
	pop ax                     ; get sum back
	call printnum              ; print AX in decimal

	mov ah,4ch
	int 21h

; ---- print AX as an unsigned decimal number ----
printnum proc
	mov bx,10
	mov cx,0                   ; digit counter
divloop:
	mov dx,0                   ; DX:AX / 10
	div bx                     ; AX = quotient, DX = remainder (a digit)
	push dx                    ; save digit (they come out in reverse)
	inc cx
	cmp ax,0
	jne divloop
printloop:
	pop dx                     ; digits now come out in correct order
	add dl,30h                 ; digit -> ASCII
	mov ah,02h
	int 21h
	loop printloop
	ret
printnum endp

code ends
end start