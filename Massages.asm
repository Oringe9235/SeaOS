org 07c00h
mov ax,cs
mov ds,ax
mov es,ax
call start
jmp $
start:
    mov ax, Massage
    mov bp,ax
    mov cx,16
    mov dl,0
    mov bx,000ch
    mov ax,1301h
    int 10h
    ret
Massage: db 'SeaOS, was born!'
times 510 - ($ - $$) db 0
dw 0xaa55 

