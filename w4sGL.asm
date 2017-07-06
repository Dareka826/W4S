;Draws pixel on screen
;cx - x
;dx - y
;al - color
drawPixel:
  mov ah, 0x0c
  mov bl, 0
  int 10h
  
  ret
  
;Initialize video mode
;al - video mode
setupVideoMode:
  mov ah, 00h
  
  int 10h
  ret
  
;most parameters should be put on stack with following order
;push [startX]
;push [startY]
;push [endX]
;push [endY]
;push [color]
;sp in ax
;FINISHED(???)
drawRectangle:
pop word [address] ;pop address to return to, that is pushed by 'call' and later used by 'ret'
				   ;since this code changes 'sp', it's safer to store this address :) (like, it might get lost somewhere in memory)
				   ;(even restoring 'sp' doesn't help enough)
mov bx, sp
mov [oldsp], bx
xor bx, bx
mov sp, ax ;restore stack


pop word [color]
pop word [endY]
pop word [endX]
pop word [startY]
pop word [startX]


;mov ax, [startX]
;cmp ax, [endX]
;jge .error_X
;xor ax, ax
;mov ax, [startY]
;cmp ax, [endY]
;jge .error_Y

mov cx, 0

.loop:
  cmp cx, [endX]
  je .done
  mov bx, 0
.loop2:
	cmp bx, [endY]
  je .loop2Done
		   
	pusha
  mov al, [color]
	mov dx, bx
	add dx, [startX]
	add cx, [startY]
	call drawPixel
	popa	   
  inc bx
  jmp .loop2
.loop2Done:
  inc ecx
  jmp .loop
.done:	
	mov bx, [oldsp]
	mov sp, bx
	xor bx, bx

	push word 0
  jmp [address]
;.error_X:
;	mov cx, [startX]
;	mov dx, [startY]
;	mov al, 0x4
;	call drawPixel
;	mov bx, [oldsp]
;	mov sp, bx
;	xor bx, bx
;	push word 1
;	jmp [address]
;.error_Y:
;	mov cx, [startX]
;	mov dx, [startY]
;	mov al, 0xc
;	call drawPixel
;	mov bx, [oldsp]
;	mov sp, bx
;	xor bx, bx
;	push word 2
;	jmp [address]

oldsp: dw 0
startX: dw 0
startY: dw 0
endX: dw 0
endY: dw 0
looper: dw 0
looper2: dw 0
color: dw 0
address: dw 0
;VESA-Compliant video mode 1024x768
;I'm not sure what's it, but Wikipedia says it makes graphics HD with 256 colors
;Well, that's not RGBA, but still, it's huge improvement over text mode...
setupVESA:
  mov ax, 0x4f02
  mov bx, 0x105
  int 10h
  ret
