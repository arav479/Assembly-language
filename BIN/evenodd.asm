; PROGRAM: CHECK WHETHER A NUMBER IS EVEN OR ODD
CR      EQU 0DH
LF      EQU 0AH

data segment
	num  db 25                     ; number to test (change this)
	msg1 db "THE NUMBER IS EVEN", CR, LF, '$'
	msg2 db "THE NUMBER IS ODD", CR, LF, '$'
data ends

code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax

	mov al,num                 ; load the number
	test al,01h                ; AND with 1, only flags change (AL is kept)
	jz even                    ; ZF=1 -> last bit is 0 -> even

odd:
	mov ah,09h
	lea dx,msg2                ; "THE NUMBER IS ODD"
	int 21h
	jmp quit

even:
	mov ah,09h
	lea dx,msg1                ; "THE NUMBER IS EVEN"
	int 21h

quit:
	mov ah,4ch
	int 21h
code ends
end start