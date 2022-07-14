loader_base_addr equ 0x900
kernel_base_addr equ 0x1500
kernel_next_section equ 0x9
section loader vstart=loader_base_addr

    mov eax,kernel_next_section
    mov bx,kernel_base_addr
    mov cx,8
    call read_disk
    jmp kernel_base_addr
    read_disk:
        mov esi,eax
        mov di,cx
        mov dx,0x1f2
        mov al,cl
        out dx,al

        ;reloaded EAX
        ;0-7
        mov eax,esi

        mov dx,0x1f3
        out dx,al

        ;8-15
        mov cl,8
        shr eax,cl
        mov dx,0x1f4
        out dx,al

        ;16-23
        shr eax,cl
        and al,0x0f
        mov dx,0x1f5
        out dx,al
        
        ;24-27
        shr eax,cl
        and al,0x0f
        or al,0xe0
        mov dx,0x1f6
        out dx,al

        ;reading code
        mov dx,0x1f7
        mov al,0x20
        out dx,al

        ;
        .not_ready:
            nop
            in al,dx
            and al,0x88
            cmp al,0x08
            jnz .not_ready
            
        ;reading data by disk
        mov ax,di
        mov dx,512
        mul dx
        mov cx,ax
        mov dx,0x1f0
        .run:
            in ax,dx
            mov [bx],ax
            add bx,2
            loop .run
    ret
