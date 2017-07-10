;W4S Graphic Library
;If you provide an original library developer (MarcinJXXXX) or a link to this file / repository / branch, you can do anything with W4SGL except for publishing it as your own project. 
;You can do with this library what you want as long as you give it to the author.


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
;sp NO LONGER in ax
;FINISHED(???)
drawRectangle:
pop word [address] ;pop address to return to, that is pushed by 'call' and later used by 'ret'
pop word [color]
pop word [endY]
pop word [endX]
pop word [startY]
pop word [startX]

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
	push word 0
  	jmp [address]

startX: dw 0
startY: dw 0
endX: dw 0
endY: dw 0
color: dw 0
address: dw 0
;VESA-Compliant video mode 1024x768
;I'm not sure what's it, but Wikipedia says it makes graphics HD with 256 colors
;Well, that's not RGBA, but still, it's huge improvement over text mode...
setupVesa:
  mov ax, 0x4f02
  mov bx, 0x105
  int 10h
  ret
