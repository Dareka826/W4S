;itoa_16 convert 'uint16_t' (16 bit unsigned integer) to string
;ax - number
;bx - pointer
;cx - base
;dx - how many chars should be print, 0 if no formatting

itoa_16_data:
	digit db "0123456789ABCDEF",0
	p dw 0
	shifter dw 0
	i dw 0
	base dw 0
	hmc dw 0

itoa_16:
	mov [i], ax
	mov [shifter], ax
	mov [p], bx
	mov [base], cx
	mov [hmc], dx
	pusha
	cmp dx, 0
		je .case0
.casenot0:
      
	mov byte [bx], '0'
	mov bx, [p]
  	inc bx
  	mov [p], bx 

   
 	mov ax, [hmc]
 	dec ax
 	mov [hmc], ax
   
  	cmp ax, 0
  	jne .casenot0
	jmp .end_if
.case0:
	.loop0:

   	        mov bx, [p]
   	        inc bx
  	        mov [p], bx 
   
           	mov ax, [shifter]
   	        xor dx, dx
   	        mov bx, [base]
           	idiv bx
   	        mov [shifter], ax
   
   	        cmp ax, 0
   		        jne .loop0
.end_if:
	popa
	pusha
	mov bx, [p]
	mov byte [bx], 0
	mov [p], bx

	popa
	pusha
	.loop1:
		mov bx, [p]
		dec bx
		mov [p], bx
		
		mov ax, [i];i
		xor dx, dx
		mov cx, [base]
		idiv cx
		
		mov bx, [p]
		add dx, digit
		mov si, dx
		mov cl, [si]
		mov byte [bx], cl
		mov [i], ax
		cmp ax, 0
		jne .loop1
	popa
	ret

	
	
	

__itoa_16:

	push bp
	mov bp, sp
	add bp, 2
	mov ax, [bp+8]
	mov [i], ax
	mov [shifter], ax
	mov ax, [bp+6]
	mov [p], ax
	mov ax, [bp+4]
	mov [base], ax
	mov ax, [bp+2]
	mov [hmc], ax
	
	pusha
	cmp ax, 0
		je .case0
	mov bx, [bp+6]
.casenot0:
	
	mov byte [bx], '0'
	mov bx, [p]
  	inc bx
  	mov [p], bx 

   
 	mov ax, [hmc]
 	dec ax
 	mov [hmc], ax
	
  	cmp ax, 0
  	jne .casenot0
	jmp .end_if
.case0:
	.loop0:

   	        mov bx, [p]
   	        inc bx
  	        mov [p], bx 
   
           	mov ax, [shifter]
   	        xor dx, dx
   	        mov bx, [base]
           	idiv bx
   	        mov [shifter], ax
			
   	        cmp ax, 0
   		        jne .loop0
.end_if:
	popa
	pusha
	mov bx, [p]
	mov byte [bx], 0
	mov [p], bx

	popa
	pusha
	.loop1:
		mov bx, [p]
		dec bx
		mov [p], bx
		
		mov ax, [i];i
		xor dx, dx
		mov cx, [base]
		idiv cx
		
		mov bx, [p]
		add dx, digit
		mov si, dx
		mov cl, [si]
		mov byte [bx], cl
		mov [i], ax
		cmp ax, 0
		jne .loop1
	popa
	pop bp
	
	ret
