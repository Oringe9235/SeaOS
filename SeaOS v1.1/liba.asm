
bits 16
[global printInPos]
[global putchar]
[global getcommand]
[global clear]
[global shutdown]

getcommand:
    mov ah,0
    int 16h
    mov ah,0
    retf

putchar:
    pusha
    mov bp,sp
    add bp,16 + 4
    mov al,[bp]
    mov bh,0
    mov ah,0eh
    int 10h
    popa
    retf

printInPos:
    pusha
    mov si,sp
    add si,16 + 4
    mov ax,cs
    mov ds,ax
    mov bp,[si]
    mov ax,ds
    mov es,ax
    mov cx,[si + 4]
    mov ax,1301h
    mov bx,0007h
    mov dh,[si + 8]
    mov dl,[si +12]
    int 10h
    popa
    retf

clear:
    pusha
    mov ax,0003h
    int 10h
    popa
    retf

shutdown:
    mov ax,5307H
    mov bx,0001H
    mov cx,0003H
    int 15h
    
