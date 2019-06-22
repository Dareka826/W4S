MainMenu:
	push bp
	mov bp, sp
	sub sp, 2
	call ClearScreen	
	mov cx, 5
.loop:
	push cx
	xor cx, cx
	mov si, NewlineMsg
	call PrintString
	pop cx
	dec cx
	cmp cx, 0
		je .loopend
	jmp .loop
.loopend:
	
	xor bx, bx
	xor cx, cx
	mov ah, 3
	int 10h
	add dl, (Play.msg - Play)
	mov [bp-2], dh
	mov [Play.posX], dl
	mov [Play.posY], dh
	xor bx, bx
	xor cx, cx
	xor dx, dx
	mov si, Play
	call PrintString
	
	mov si, Special
	call PrintString
	
	xor bx, bx
	xor cx, cx
	mov ah, 3
	int 10h
	add dl, (Highscores.msg - Highscores)
	mov [Highscores.posX], dl
	mov [Highscores.posY], dh
	xor bx, bx
	xor cx, cx
	xor dx, dx
	mov si, Highscores
	call PrintString

.entryloop:
	pusha
	mov al, [Play.posY]
	mov bl, [Highscores.posY]
	mov cl, [bp-2]
		
	cmp byte [bp-2], al
		jng .CursorTooHigh
	cmp byte [bp-2], bl
		jg .CursorTooLow
		
	jmp .positionCorrect
.CursorTooHigh:
	mov byte [bp-2], al
	jmp .positionCorrect
.CursorTooLow:
	mov byte [bp-2], bl
	jmp .positionCorrect
.positionCorrect:
	popa
	mov ah, 2
	xor bx, bx
	mov dh, [bp-2]
	mov dl, 0
	int 10h
	
	push word 0xf1f1
	call LineChangeColorAttribute
	mov ah, 0
	int 16h
	
	push ax
	
	mov ah, 2
	xor bx, bx
	mov dh, [bp-2]
	mov dl, 0
	int 10h
	
	push word 0x1f1f
	call LineChangeColorAttribute
	
	pop ax
	cmp ah, 0x50 ; down arrow
		je .down
	cmp ah, 0x48 ; up arrow
		je .up
	cmp ah, 0x1c ; return / enter
		je .confirm
	
	jmp .entryloop
.down:
	inc word [bp-2]
	jmp .entryloop
.up:
	dec word [bp-2]
	jmp .entryloop
.confirm:
	mov ah, 0
	mov al, [bp-2]
	sub al, [Play.posY]
	mov sp, bp
	pop bp
	xchg bx, bx
	ret


NewlineMsg: db 0xd,0xa,0

Play:
	times (80 - (.msgEnd - .msg)) / 2 + 1 db ' '
.msg: db "Play",0xd,0xa,0
.msgEnd: times (80 - (.msgEnd - .msg)) / 2 - 1 db ' '
.posX: db 0
.posY: db 0

Special: 	times (80 - (.msgEnd - .msg)) / 2 + 1 db ' '
.msg: db "Special",0xd,0xa,0
.msgEnd: times (80 - (.msgEnd - .msg)) / 2 - 1 db ' '

Highscores:
	times (80 - (.msgEnd - .msg)) / 2 + 1 db ' '
.msg: db "Highscores",0xd,0xa,0
.msgEnd: times (80 - (.msgEnd - .msg)) / 2 - 1 db ' '
.posX: db 0
.posY: db 0
