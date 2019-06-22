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
%include "mainmenu.asm"
tmpBuffer: times 16 db 0



main:
	call Load
	call ClearScreen
	;call LogIn

.mainmenu:	
	call MainMenu

	cmp ax, 0
		je fPlay
	cmp ax, 1
		je fSpecial
	cmp ax, 2
		je fHighscores

	jmp .mainmenu
fPlay:
	call ClearScreen
	
	mov ah, 2
	mov bh, 0
	mov dh, 10
	mov dl, 24
	int 10h
	
	mov si, msg
	call PrintString
	

mainLoop:

	cmp byte [whLeg], 0
		je .drawLeg1
	jmp .drawLeg2
.returnPoint:

	mov ah, 2
	mov bh, 0
	mov dh, 12
	mov dl, 36
	int 10h
	
	mov si, msg2
	call PrintString
	
	mov ah, 2
	mov bh, 0
	mov dh, 14
	mov dl, 0
	int 10h
	
	mov si, legz
	call PrintString

	mov ah, 2
	mov bh, 0
	mov dh, 13
	mov dl, 38
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
.drawLeg1:
	call PrintLeftLeg
	jmp .returnPoint
.drawLeg2:
	call PrintRightLeg
	jmp .returnPoint
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
	call ClearScreen
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
	
fSpecial:
	mov si, unimplemented
	call PrintString
	jmp $
	
fHighscores:
	mov si, unimplemented
	call PrintString
	jmp $

osName: db "Weed 4 Spacer OS 2020-1 v1.6-kwasy",234,"_3 [NonPremium]", 0

logoz: db "By MB", 0
logoz2: db "& MJX", 0

unimplemented: db "Error: unimplemented function",0xd,0xa,0

unamemsg: db "Username", 0
username: db "         ", 0

loadMsg: db "Loading...", 0
loadProg: db 0,0

msg: db "U Weed To Spacer! With Ur legz", 0
msg2: db "Ur score: ", 0

score: dw 0,0
scoree: times 16 db 0
legz: db 27,"Lewa Noga"," "
times 80 - 22 db " "
db "Prawa Noga",26, 0
whLeg: db 0

rlEeG:
.line1:	db	"               ",0
.line2:	db	"  ",219,219,219,219,219,219,220,220,220,"    ",0
.line3:	db	" ",219,219,219,219,219,219,219,219,219,219,219,219,220," ",0
.line4: db 	"  ",219,219,219,223,223,219,219,219,219,219,219,223," ",0
.line4end:

llEeG:
.line1:	db 	"               ",0
.line2:	db	"    ",220,220,220,219,219,219,219,219,219,"  ",0
.line3:	db	" ",220,219,219,219,219,219,219,219,219,219,219,219,219," ",0
.line4:	db	" ",223,219,219,219,219,219,219,223,223,219,219,219,"  ",0
.line4end:

not_bat: db "Not bad... not bad...",0
uluser: db "u LUZER!", 0
new_high: db "C0ngrLz, n00b! Nev lowZC0R!",0
buffer__: times 512 db 0

times (512*15)-($-$$) db 0
def: 	db 0,0
times (512*16)-($-$$) db 0
