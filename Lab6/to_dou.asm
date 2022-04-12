PUBLIC str_to_2num 
PUBLIC output_dou 

EXTRN dou: byte
EXTRN hexi: word


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
    

output_dou proc near
    push ds
    push bx 
    push es 
    
    mov cx, 15
    mov ah, 02h

    shl bx, 1

    output_digits_loop:
        mov dl, 0
        shl bx, 1
        adc dl, 30h
        int 21h
    loop output_digits_loop

    pop es 
    pop bx 
    pop ds 
    ret
output_dou endp

str_to_2num proc near
    push bx 
    push ax
    push si
    push di
    push ds
    assume DS:SEG hexi
    mov ax, SEG hexi
    mov ds, ax

    mov ax, hexi
    mov si, 0

    mov bx, ax
    shl bx, 1
    shr bx, 1
 
    cmp bx, ax 
    je plus_sign

    neg_sign:
        mov dl, '-'
    	mov ah, 02h
    	int 21h 
        mov bx, hexi
        sub bx, 1
        not bx
        ;neg bx
        
        call output_dou
        jmp ret_bl

    plus_sign:
        mov dl, '+'
    	mov ah, 02h
    	int 21h 
        mov bx, hexi
        call output_dou

    ret_bl:
        pop ds
        pop di
        pop si
        pop ax
        pop bx
        ret
str_to_2num endp

Code ENDS

END