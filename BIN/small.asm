data segment 
	arr db 3,4,2,5
	n db 4
	msg db "the smallest is = $"
	small db ?
	data ends

code segment
	assume cs:code ds:data
	
	start:
	mov ax,data
	mov ds,ax
	
	lea si,arr
	mov al,[si]
	mov cl,n
	mov ch,0
	inc si
	dec cl
	
	next:
	cmp al,[si]
	jbe skip
	mov al,[si]
	skip:
	inc si
	loop next
	
	mov small,al
	mov ah,09h
	lea dx,msg
	int 21h
	
	mov dl,small
	add small,30h
	mov ah,02h
	int 21h
	
	mov ah,4ch
	int 21h
	
	code ends
	end start
	
	
	  
	
	
	
	