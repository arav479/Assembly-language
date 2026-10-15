; PROGRAM: SORT NUMBERS IN ASCENDING ORDER (BUBBLE SORT)
data segment
	arr  db 3,2,1
	n    db 3
	msg1 db "original numbers = $"
	msg2 db "in ascending order = $"
	crlf db 13,10,'$'
data ends

code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax              ; FIX: was "mov dx,ax" - must load DS

	; ---- print original numbers ----
	mov ah,09h
	lea dx,msg1
	int 21h
	call display

	; ---- bubble sort ----
	mov ch,0
	mov cl,n
	dec cl                 ; passes = n-1 = 2

outer:
	push cx                ; save outer count
	lea si,arr             ; start of array for each pass

inner:
	mov al,[si]            ; current element
	mov bl,[si+1]          ; next element
	cmp al,bl
	jae noswap             ; if al <= bl, already in order
	mov [si],bl            ; otherwise swap the two
	mov [si+1],al
noswap:
	inc si
	loop inner             ; CX = CX-1, repeat while CX != 0

	pop cx                 ; restore outer count
	loop outer

	; ---- print sorted numbers ----
	mov ah,09h
	lea dx,msg2
	int 21h
	call display

	mov ah,4ch             ; exit to DOS
	int 21h

; ---- procedure: print the array (single-digit numbers) ----
display proc
	lea si,arr
	mov cl,n
	mov ch,0
show:
	mov dl,[si]
	add dl,30h             ; number -> ASCII digit
	mov ah,02h
	int 21h
	mov dl,' '
	mov ah,02h
	int 21h
	inc si
	loop show
	mov ah,09h
	lea dx,crlf            ; new line
	int 21h
	ret
display endp

code ends
end start