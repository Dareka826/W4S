struc Vector2
.x resw 1
.y resw 1
endstruc

[global v2zero]
v2zero: istruc Vector2
at Vector2.x dw 0
at Vector2.y dw 0
iend

struc Vector3
.x resw 1
.y resw 1
.z resw 1
endstruc

[global v3zero]
v3zero: istruc Vector3
at Vector3.x dw 0
at Vector3.y dw 0
at Vector3.z dw 0
iend

[global mVect2Add]
;[global mVect2Sub]
;[global mVect2Mul]
;[global mVect2Div]

mVect2Add:
.a1: istruc Vector2
times 2 dw 0
iend
.a2: istruc Vector2
times 2 dw 0
iend
mov word [.a1], ax
mov word [.a2], bx
mov ax, [.a1 + Vector2.x]
mov bx, [.a2 + Vector2.x]
add ax, bx

mov cx, [.a1 + Vector2.y]
mov dx, [.a2 + Vector2.y]
add cx, dx

mov bx, cx


ret
