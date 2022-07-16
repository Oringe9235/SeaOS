loader_base_addr equ 0x900
loader_next_section equ 0x2
    section mar vstart=0x7c00

    mov ax,cs
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov fs,ax
    mov sp,0x7c00
    mov ax,0xb800
    mov gs,ax

    mov ax,0x0600
    mov bx,0x0700
    mov cx,0
    mov dx,184fh
    int 10h
    ;output
    mov byte[gs:0x00],'*'
    mov byte[gs:0x01],0x02
    mov byte[gs:0x02],'*'
    mov byte[gs:0x03],0x02
    mov byte[gs:0x04],'M'
    mov byte[gs:0x05],0x02
    mov byte[gs:0x06],'B'
    mov byte[gs:0x07],0x02
    mov byte[gs:0x08],'R'
    mov byte[gs:0x09],0x02
    mov byte[gs:0x0a],'*'
    mov byte[gs:0x0b],0x02
    mov byte[gs:0x0c],'*'
    mov byte[gs:0x0d],0x02

    ;loading Loader
    mov eax,loader_next_section
    mov bx,loader_base_addr
    mov cx,1
    call read_disk
    jmp loader_base_addr
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

    times 510 - ($ - $$) db 0600h
    db 0x55,0xaa
