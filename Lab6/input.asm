PUBLIC input_number 
PUBLIC print_new_line


EXTRN buff: byte
EXTRN str_to_16num: near
EXTRN str_to_2num: near



TmpSeg SEGMENT PARA PUBLIC 'DATA'
    hell db "Input: $"
TmpSeg ENDS

Code SEGMENT PARA PUBLIC 'CODE'
	assume CS:Code

input_number PROC near
    push ds

    assume DS:TmpSeg 
    mov ax, TmpSeg 
    mov ds, ax

    mov ah, 9
    mov dx, offset hell
    int 21h

    assume DS:SEG buff
    mov ax, SEG buff
    mov ds, ax

	mov dx, offset buff
	mov ah, 0ah
	int 21h

    mov cx, 0h

    call str_to_16num

    pop ds
	ret 
input_number endp

print_new_line PROC near

    push ds

    assume DS:TmpSeg 
    mov ax, TmpSeg 
    mov ds, ax

    mov dx, 0h
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h

    pop ds
	ret 
print_new_line endp
    

Code ENDS

END