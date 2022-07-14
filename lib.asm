bits 16
[global printPos]
[global putchar]
[global getch]
[global shutdown]
[global clear]
[global times]
[global callPM]

getch:
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

printPos:
    pusha
    mov si,sp
    mov si,16 + 4
    mov ax,cs
    mov ds,ax
    mov bp,[si]
    mov ax,ds
    mov es,ax
    mov cx,[si + 4]
    mov ax,1301h
    mov bx,0007h
    mov dh,[si + 8]
    mov dl,[si + 12]
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

times:
    pusha
    ;year
    mov al,'2'
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,'0'
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,09h
    out 70h,al
    in al,71h
    mov ah,al
    mov cl,4
    shr ah,cl
    and al,00001111B
    add ah,30h
    add al,30h

    mov dx,ax
    mov al,dh
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,dl
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,'.'  ;时间分隔符，如：2022.07.14-12:04
    mov bh,0
    mov ah,0eh
    int 10h
    ;mouth
    mov al,08h
    out 70h,al
    in al,71h
    mov ah,al
    mov cl,4
    shr ah,cl
    and al,00001111B
    add ah,30h
    add al,30h

    mov dx,ax
    mov al,dh
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,dl
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,'.'
    mov bh,0
    mov ah,0eh
    int 10h
    ;day
    mov al,07h
    out 70h,al
    in al,71h
    mov ah,al
    mov cl,4
    shr ah,cl
    and al,00001111B
    add ah,30h
    add al,30h

    mov dx,ax
    mov al,dh
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,dl
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,'-'
    mov bh,0
    mov ah,0eh
    int 10h
    ;hour
    mov al,4
    out 70h,al
    in al,71h
    mov ah,al
    mov cl,4
    shr ah,cl
    and al,00001111B
    add ah,30h
    add al,30h

    mov dx,ax
    mov al,dh
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,dl
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,':'
    mov bh,0
    mov ah,0eh
    int 10h
    ;minute
    mov al,2
    out 70h,al
    in al,71h
    mov ah,al
    mov cl,4
    shr ah,cl
    and al,00001111B
    add ah,30h
    add al,30h

    mov dx,ax
    mov al,dh
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,dl
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,':'
    mov bh,0
    mov ah,0eh
    int 10h
    ;second
    mov al,0
    out 70h,al
    in al,71h
    mov ah,al
    mov cl,4
    shr ah,cl
    and al,00001111B
    add ah,30h
    add al,30h

    mov dx,ax
    mov al,dh
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,dl
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,0ah
    mov bh,0
    mov ah,0eh
    int 10h

    mov al,0dh
    mov bh,0
    mov ah,0eh
    int 10h
    popa
    retf

callPM:
	;进入保护模式
	MOV EAX,20				;LBA 读入的扇区起始偏移
	MOV BX,0X9000				;保护模式下KERNEL的起始地址
	MOV CX,10					;读入扇区个数
			  
	CALL READ_DISK
	JMP 0x9000
	READ_DISK:
    ;EAX LBA 扇区号
    ;BX 数据写入内存的地址
    ;CX 读入扇区数

    ;保存寄存器 EAX CX
    MOV ESI, EAX
    MOV DI, CX
    ;设置读取扇区的数量
    ;读写硬盘
    MOV DX, 0X1F2         	;
    MOV AL, CL            	;
    OUT DX, AL

    ;恢复 EAX
    MOV EAX, ESI

    ;将LBA的地址存入 0x1f3-0x1f6，设置起始扇区编号
    ;0-7 写入0x1f3
    MOV DX, 0X1F3
    OUT DX, AL
    ;8-15 写入0x1f4
    MOV CL, 8
    SHR EAX, CL
    MOV DX, 0X1F4
    OUT DX, AL
    ;16-23 写入0x1f5
    SHR EAX, CL
    AND AL, 0X0F
    MOV DX, 0X1F5
    OUT DX, AL
    ;24 - 27
    SHR EAX, CL
    AND AL, 0X0F
    OR AL, 0XE0           	;AL = 1110 0000
    MOV DX, 0X1F6
    OUT DX, AL
    ;向0x1f7 写入读命令
    MOV DX, 0X1F7
    MOV AL, 0X20          	;表示读命令

    OUT DX, AL
    ;检测硬盘状态
    .NOT_READY:
        NOP
        ;读取端口，查看状态
        IN AL, DX
        AND AL, 0X88          	;第4位为1表示可以传输，第7位为1表示繁忙
        CMP AL, 0X08
        JNZ .NOT_READY
        ;读数据
        MOV AX, DI            	;这里 DI = 1
        MOV DX, 512
        MUL DX
        MOV CX, AX
        MOV DX, 0X1F0
        .GO:
            IN AX, DX
            MOV[BX], AX           	;向BASE_ADDR(内存0x8000)写数据
            ADD BX, 2
            LOOP .GO
            RET

