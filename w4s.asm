[bits 16]
[org 0x7C00]

mov ax, 0
mov fs, ax
mov gs, ax
mov ss, ax
mov es, ax

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

jmp main

%include "highscores.asm"
%include "W4Slib/w4slib_general_functions.asm"
%include "print.asm"


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
	
	mov ax, [score]
	inc ax
	mov [score], ax
	
	mov al, 1
	mov [whLeg], al
	jmp AfterArrows
	
CheckPrawa:
	cmp ah, 0x4D
	jne AfterArrows
	
	mov al, [whLeg]
	cmp al, 1
	jne Przegryw

	
	mov ax, [score]
	inc ax
	mov [score], ax
	
	mov al, 0
	mov [whLeg], al
	
AfterArrows:
	
	jmp mainLoop

Przegryw:
	call ClearScreen
	
	
	call LoadHighScores
	


	mov ah, 2
	mov bl, 0
	mov dh, 8
	mov dl, 35
	int 10h
	call PrintScore
	
	mov ax, [score]
	mov bx, [def]
	
	cmp ax, bx
	jng .normal 
	
	mov ah, 2
	mov bl, 0
	mov dh, 7
	mov dl, 28
	int 10h
	
	mov si, new_high
	call PrintString
	call WriteHighScores
	mov ah, 2
	mov bl, 0
	mov dh, 9
	mov dl, 30
	int 10h
	
	mov si, not_bat
	call PrintString
	
	jmp .end__i
	
.normal:
	mov si, uluser
	call PrintString
	
	mov ax, [def]
	mov [score], ax
	
	;call PrintScore
.end__i:	
	mov ah, 0x86
	mov cx, 0x4C
	mov dx, 0x4B40
	int 15h

	db 0x0ea
    dw 0x0000
    dw 0xffff

PrintScore:
	pusha
	mov ax, [score]
	mov bx, scoree
	mov cx, 10
	mov dx, 5
	call itoa_16
	popa
	
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
	mov cx, 0x0
	mov dx, 0x2000
	int 15h
	
	mov ah, [loadProg]
	cmp ah, 78
	je LoadEnd
	
	inc ah
	mov [loadProg], ah
	
	jmp LoadLoop
LoadEnd:
	ret

osName: db "Weed 4 Spacer OS 2018-1 v1.1-kwasy",234,"_3 [NonPremium]", 0

logoz: db "By MB", 0
logoz2: db "& MJX", 0

unamemsg: db "Username", 0
username: db "         ", 0

loadMsg: db "Loading...", 0
loadProg: db 0,0

msg: db "U Weed To Spacer! With Ur legz", 0
msg2: db "Ur score: ", 0

score: dw 0,0
scoree: times 16 db 0
legz: db "Lewa Noga     Prawa Noga", 0
whLeg: db 0

not_bat: db "Not bad... not bad...",0
uluser: db "u LUZER!", 0
new_high: db "C0ngrLz, n00b! Nev lowZC0R!",0
buffer__: times 512 db 0

times (512*15)-($-$$) db 0
def: 	db 0,0
times (512*16)-($-$$) db 0
