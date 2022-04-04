PUBLIC str_to_2num 

EXTRN buff: byte
EXTRN dou: word


TmpSeg SEGMENT PARA 'DATA'

TmpSeg ENDS

Code SEGMENT PARA PUBLIC 'CODE'
	assume CS:Code

output_symb proc
    push ax 
    xor ax, ax
    mov ah, 2
    int 21h
    pop ax
    ret 
output_symb endp
    

output_dou proc 
 
output_dou endp

str_to_2num proc near
    push bx 
    push ax
    push si
    push di
    push ds

    assume DS:SEG buff
    mov ax, SEG buff
    mov ds, ax

    

    mov hexi, di
    call output_hex

    pop ds
    pop di
    pop si
    pop ax
    pop bx

    ret
str_to_2num endp

Code ENDS

END