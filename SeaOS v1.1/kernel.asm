bits 16
[extern startUp]
[extern shell]

global _start
_start:
    call dword startUp
    
Key_board:
    mov ah,0
    int 10h
    cmp al,0dh
    call dword shell
    jmp Key_board

