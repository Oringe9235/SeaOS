bits 16
[extern startUp]
[extern shell]

global _start
_start:
call dword startUp

key_board:
mov ah,0
int 16h
cmp al,0dh
jne key_board
call dword shell
jmp key_board
