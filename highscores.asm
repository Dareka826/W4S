LoadHighScore:
	jmp .jmp_over
	temp_username: db "         ", 0
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
	mov ah, [buffer__]
	mov [def], ah
	mov ah, [buffer__+1]
	mov [def+1], ah
.loop:
	cmp dh, 8
	jge .end_loop
	inc dh
	mov si, dh
	add si, 2
	mov ah, [buffer__+si]
	sub si, 2
	mov [temp_username+si], ah
	jmp .loop 
.end_loop:
	mov si, def
	call PrintString
	popa
	ret
	
WriteHighScores:
	pusha
	mov ah, [score]
	mov [buffer__], ah
	mov ah, [score+1]
	mov [buffer__+1], ah
	mov dh, 0
.loop:
	cmp dh, 8
	jge .end_loop
	inc dh
	mov si, dh
	mov ah, [username+si]
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
