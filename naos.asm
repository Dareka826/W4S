[bits 16]
[org 0x7C00]

mov ah, 2
mov al, 5
mov ch, 0
mov cl, 2
mov dh, 0
mov dl, 0x80
mov bx, 0x7E00
int 13h
jmp 0x7E00

times 510-($-$$) db 0
dw 0xAA55

mov ah, 0x10
mov al, 3
mov bl, 0
int 10h

main:
	;call Load
	;call ClearScreen
	;call LogIn
	call ClearScreen
mainLoop:
	mov ah, 2
	; implement weed 4 spacer
	int 10h
	
	jmp mainLoop

LogIn:
	mov ah, 2
	mov bh, 0
	mov dh, 10
	mov dl, 35
	int 10h
	
	mov si, unamemsg
	call PrintString
	
	mov ah, 2
	mov bh, 0
	mov dh, 11
	mov dl, 35
	int 10h
	
	mov si, username	
LogInLoop:
	mov ah, 0
	int 16h
	
	cmp al, 13
	je LogInEnd
	
	mov bx, si
	sub bx, username
	cmp bx, 8
	je LogInEnd
	
	mov [si], al 
	inc si
	
	call PrintChar
	
	jmp LogInLoop
LogInEnd:
	ret

Load:
	mov ah, 2
	mov bh, 0
	mov dx, 0
	int 10h
	
	mov ah, 9
	mov al, ' '
	mov bh, 0
	mov bl, 0x0F
	mov cx, 0x7D0
	int 10h
	
	mov ah, 2
	mov bh, 0
	mov dh, 11
	mov dl, 36
	int 10h
	
	mov si, logoz
	call PrintString
	
	mov ah, 0x86
	mov cx, 0x1E
	mov dx, 0x8480
	int 15h
	
	mov ah, 2
	mov bh, 0
	mov dh, 11
	mov dl, 36
	int 10h
	
	mov si, logoz2
	call PrintString
	
	mov ah, 0x86
	mov cx, 0x1E
	mov dx, 0x8480
	int 15h
	
	call ClearScreen
	
	mov ah, 2
	mov bh, 0
	mov dh, 11
	mov dl, 36
	int 10h
	
	mov si, loadMsg
	call PrintString
	
LoadLoop:
	mov ah, 2
	mov bh, 0
	mov dh, 12
	mov dl, 1
	int 10h
	
	mov ah, 9
	mov al, ' '
	mov bh, 0
	mov bl, 0xFF
	mov cx, [loadProg]
	int 10h
	
	mov ah, 0x86
	mov cx, 0x3
	mov dx, 0xD090
	int 15h
	
	mov ah, [loadProg]
	cmp ah, 78
	je LoadEnd
	
	inc ah
	mov [loadProg], ah
	
	jmp LoadLoop
LoadEnd:
	ret

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

osName: db "Weed 4 Spacer OS 2017", 0

logoz: db "By MB", 0
logoz2: db "& MJX", 0

unamemsg: db "Username", 0
username: db "        ", 0

loadMsg: db "Loading...", 0
loadProg: db 0

times (512*6)-($-$$) db 0
