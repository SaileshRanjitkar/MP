.model small
.data
msg1 db 0db 0dh,0ah,"enter alphanumeric character $"
res db 02 dup(0)
.code
mov ax,@dta
mov ds,axlea dx,msg1
call disp
mov ah,01h
mov bl,al
mov cl,4        ;     :=3A=3341
shr al,cl      ;AL=31  AL=03  BL=3A
cmp al,0ah     ;bl=3A     30     OF
jc digit         ;        33     OA
ADD AL,07H
digit: add al,30h
	mov res,al
	and bl,ofh
	cmp bl,0ah
	jc digit1
digit:add bl,30h
	mov res1,bl
	
	mov ah,00h
	mov al,03h     ;TEXT MODE
	int 10h
	
	mov ah,02h     ;SET THE CURSOR POS
	mov bh,00h       ;PAGE NUMBER
	mov dh,0ch         ;ROW (00 IS TOP
	mov dl,28h        ;COLUMN VAL
	int 10h
	
	mov res+2,'$'
	lea dx,res 
	call disp
	mov ah,4ch
	int 21h
	
	disp proc near 
	mov ah,09h
	int 21h
