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
	call Load
	call ClearScreen
	call LogIn
	
	
	call ClearScreen
	
	mov ah, 2
	mov bh, 0
	mov dh, 10
	mov dl, 24
	int 10h
	
	mov si, msg
	call PrintString
	
	mov ah, 2
	mov bh, 0
	mov dh, 11
	mov dl, 32
	int 10h
	
	mov si, msg2
	call PrintString
	
	mov ah, 2
	mov bh, 0
	mov dh, 13
	mov dl, 27
	int 10h
	
	mov si, legz
	call PrintString
mainLoop:
	mov ah, 2
	mov bh, 0
	mov dh, 11
	mov dl, 42
	int 10h
	
	mov ah, 9
	mov al, ' '
	mov bh, 0
	mov bl, 0x1F
	mov cx, 33
	int 10h
	
	call PrintScore
	
	mov ah, 0
	int 16h
	
	cmp ah, 0x4B
	jne CheckPrawa
	
	mov al, [whLeg]
	cmp al, 0
	jne Przegryw
	
	mov al, [score]
	inc al
	mov [score], al
	
	mov al, 1
	mov [whLeg], al
	jmp AfterArrows
	
CheckPrawa:
	cmp ah, 0x4D
	jne AfterArrows
	
	mov al, [whLeg]
	cmp al, 1
	jne Przegryw

	
	mov al, [score]
	inc al
	mov [score], al
	
	mov al, 0
	mov [whLeg], al
	
AfterArrows:
	
	jmp mainLoop

Przegryw:
	call ClearScreen
	
	mov ah, 2
	mov bl, 0
	mov dh, 11
	mov dl, 35
	int 10h
	
	mov si, uluser
	call PrintString
	
	mov ah, 0x86
	mov cx, 0x4C
	mov dx, 0x4B40
	int 15h
	
	db 0x0ea
    dw 0x0000
    dw 0xffff

PrintScore:
	mov dx, 0
	mov ax, [score]
	mov bx, 10
	div bx
	
	mov cx, ax
	mov al, '0'
	add al, dl
	mov [scoree+3], al
	mov ax, cx
	
	mov dx, 0
	div bx
	
	mov cx, ax
	mov al, '0'
	add al, dl
	mov [scoree+2], al
	mov ax, cx
	
	mov dx, 0
	div bx
	
	mov cx, ax
	mov al, '0'
	add al, dl
	mov [scoree+1], al
	mov ax, cx
	
	mov dx, 0
	div bx
	
	mov cx, ax
	mov al, '0'
	add al, dl
	mov [scoree], al
	mov ax, cx
	
	mov si, scoree
	call PrintString
	
	ret

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
	cmp bx, 9
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
	
	mov ah, 2
	mov bh, 0
	mov dh, 12
	mov dl, 1
	int 10h
	
	mov ah, 9
	mov al, ' '
	mov bh, 0
	mov bl, 0x77
	mov cx, 78
	int 10h
	
LoadLoop:
	mov ah, 2
	mov bh, 0
	mov dh, 12
	mov dl, 1
	int 10h
	
	mov ah, 9
	mov al, ' '
	mov bh, 0
	mov bl, 0xEE
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
username: db "         ", 0

loadMsg: db "Loading...", 0
loadProg: db 0,0

msg: db "U Weed To Spacer! With Ur legz", 0
msg2: db "Ur score: ", 0

score: db 0, 0
scoree: db "0000", 0
legz: db "Lewa Noga     Prawa Noga", 0
whLeg: db 0

uluser: db "u LUZER!", 0

times (512*6)-($-$$) db 0
