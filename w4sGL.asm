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
;UNFINISHED
drawRectangle:
  pop ax
  mov [color], ax
  pop ax
  mov [endY], ax
  pop ax
  mov [endX], ax
  pop ax
  mov [startY], ax
  pop ax
  mov [startX], ax
  xor ax, ax
  .loop:
    push ax
    mov ax, [looper]
    add ax, [startX]
    cmp ax, [endX]
    jge .end
    mov cx, ax
 .loop2:
    push ax
    mov ax, [looper2]
    add ax, [startY]
    cmp ax, [endY]
    jge .endloop2
    mov dx, ax
    mov al, [color]
    call drawPixel
    pop ax
    jmp .loop2
 .endloop2:
    pop ax
    mov ax, [looper]
    inc ax
    mov [looper], ax
    pop ax
    jmp .loop
  .end:
  
  pop ax
  ret
startX: dw 0
startY: dw 0
endX: dw 0
endY: dw 0
looper: db 0
looper2: db 0
color: db 0
;VESA-Compliant video mode 1024x768
;I'm not sure what's it, but Wikipedia says it makes graphics HD with 256 colors
;Well, that's not RGBA, but still, it's huge improvement over text mode...
setupVESA:
  mov ax, 0x4f02
  mov bx, 0x105
  int 10h
  ret
