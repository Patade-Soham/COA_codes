.model small
.stack 100h
.data
.code
start:
mov ax, 0Dh
int 10h

mov ah, 0Ch
mov al, 0Eh
mov cx, 160
mov dx, 100

DrawTop:
int 10h
dec cx
cmp cx, 75
jnz DrawTop

DrawLeft:
int 10h
inc dx
cmp dx, 145
jnz DrawLeft

DrawBottom:
int 10h

inc cx
cmp cx, 160
jnz DrawBottom

DrawRight:
int 10h
dec dx
cmp dx, 100
jnz DrawRight

WaitKey:
mov ah, 08h
int 21h
cmp al, 13
jnz WaitKey

mov al, 03h
mov ah, 00h
int 10h

mov ah, 4Ch
int 21h
END