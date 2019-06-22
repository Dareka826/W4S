ClearScreen:
	mov ah, 2
	mov bh, 0
	mov dx, 0
	int 10h
	
	mov ah, 9
	mov al, ' '
	mov bh, 0
	mov bl, 0x8F
	mov cx, 80
	int 10h
	
	mov ah, 2
	mov bh, 0
	mov dh, 1
	mov dl, 0
	int 10h
	
	mov ah, 9
	mov al, ' '
	mov bh, 0
	mov bl, 0x1F
	mov cx, 0x730
	int 10h
	
	mov ah, 2
	mov bh, 0
	mov dh, 24
	mov dl, 0
	int 10h
	
	mov ah, 9
	mov al, ' '
	mov bh, 0
	mov bl, 0x8F
	mov cx, 80
	int 10h
	
	mov ah, 2
	mov bh, 0
	mov dx, 0
	int 10h
	
	mov si, osName
	call PrintString
	
	mov ah, 2
	mov bh, 0
	mov dh, 24
	mov dl, 0
	int 10h
	
	mov si, username
	call PrintString
	
	mov ah, 2
	mov bh, 0
	mov dh, 1
	mov dl, 0
	int 10h
	
	ret

PrintChar:
	mov ah, 0xE
	int 10h
	
	ret

PrintString:
PrintLoop:
	mov al, [si]
	inc si
	
	cmp al, 0
	je PrintEnd
	
	call PrintChar
	jmp PrintLoop
PrintEnd:
	ret

LineChangeColorAttribute:
	push bp
	mov bp, sp
.loop:	
	mov ah, 3
	xor bx, bx
	xor cx, cx
	xor dx, dx
	int 10h
	cmp dl, 80
		jge .endloop
	pusha
	
	mov ah, 8
	xor bx, bx
	int 10h
	
	mov ah, 9
	mov cx, 1
	mov bl, [bp+4]
	int 10h
	
	popa
	inc dl
	
	mov ah, 2
	int 10h
		
	jmp .loop
.endloop:
	mov sp, bp
	pop bp
	ret 2
