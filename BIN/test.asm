

data segment
	arr db 1,2,3,4,5
	n db 5
	total dw ?
	msg1 db "The total is = 15 $"
	msg2 db "the average is =$"
	
data ends

code segment
	assume cs:code,ds:data
	start:
	mov ax,data
	mov ds,ax
	
	mov ah,09h
	lea dx,msg1
	int 21h	

	
quit:
	mov ah,4ch
	int 21h
	code ends 
	end start
	
	
	

	
	
	
	
	