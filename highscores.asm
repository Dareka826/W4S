LoadHighScores:
	jmp jmp_over
	temp_username: db "         ", 0
jmp_over:
	pusha
	mov ah, 2
	mov al, 1
	mov ch, 0
	mov cl, 16
	mov dh, 0
	mov dl, 0x80
	mov bx, buffer__
	int 13h
	mov ax, [buffer__]
	mov [def], ax
	mov dx, 0
.loop:
	cmp dx, 8
	jge .end_loop
	inc dx
	mov si, dx
	add si, 1
	mov ah, [buffer__+si]
	sub si, 2
	mov [temp_username+si], ah
	jmp .loop 
.end_loop:
	popa
	ret
	
LoadHighScoresLocal:
	jmp .jmp_over
	.temp_username: db "         ", 0
.jmp_over:
	pusha
	mov ah, 2
	mov al, 1
	mov ch, 0
	mov cl, 16
	mov dh, 0
	mov dl, 0x80
	mov bx, buffer__
	int 13h
	mov ax, [buffer__]
	mov [.def], ax
	mov dx, 0
.loop:
	cmp dx, 8
	jge .end_loop
	inc dx
	mov si, dx
	add si, 1
	mov ah, [buffer__+si]
	sub si, 2
	mov [.temp_username+si], ah
	jmp .loop 
.end_loop:
	popa
	ret
.def: dw 0
	
WriteHighScores:
	pusha

	mov ax, [score]
	mov [buffer__], ax
	mov dx, 0
.loop:
	cmp dx, 8
	jge .end_loop
	inc dx
	mov si, dx
	dec si
	mov ah, [username+si]
	inc si
	inc si
	mov [buffer__+si], ah
	jmp .loop 
.end_loop:
	mov ah, 3
	mov al, 1
	mov ch, 0
	mov cl, 16
	mov dh, 0
	mov dl, 0x80
	mov bx, buffer__
	int 13h
	popa
	ret
