LoadHighScore:
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
