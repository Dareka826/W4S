;Draws 1 pixel on screen
;cx - x
;dx - y
;al - color
drawPixel:
  mov ah, 0x0c
  mov bl, 0
  int 10h
  ret
  
;Init video mode
;al - wanted video mode
setupVideoMode:
  mov ah, 00h
  
  int 10h
  ret
  
;most parameters should be put on stack with following order
;push [startX]
;push [startY]
;push [endX]
;push [endY]
;color in al
;UNFINISHED
drawRectangle:
  mov bl, 0
  int 10h
  ret
  
;VESA-Compliant video mode 1024x768
;I'm bot sure what's it, but Wikipedia says it makes graphics HD with 256 colors
;Well that's not RGBA, but still, huge improvement over text mode...
setupVESA:
  mov ah, 0x4f02
  mov bx, 0x105
  int 10h
  ret
