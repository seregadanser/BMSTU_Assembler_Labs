EXTRN input_number : near
EXTRN print_new_line : near
EXTRN str_to_2num : near
EXTRN output_hex : near

PUBLIC buff
PUBLIC hexi
PUBLIC dou


SSTK SEGMENT PARA STACK 'STACK'
	db 100 dup(0); стек 100 байт инициализированных 0
SSTK ENDS

Main_Seg SEGMENT PARA PUBLIC 'DATA'
        buff db 6, 0, 6 dup('0')
        hexi dw 1 dup(0)
        dou db 16 dup(0)
Main_Seg ENDS

FirsSeg SEGMENT PARA 'DATA'
    message db "Press 1 to input"
    db 13, 10
    db "Press 2 to out in 16"
    db 13, 10
    db "Press 3 to out in 2" 
    db 13, 10
    db "Press 4 to exit" 
    db 13, 10
    db "$"
    adress dw 4 dup(0)
FirsSeg ENDS

Code SEGMENT PARA PUBLIC 'CODE'
    assume CS:Code
    ;START;
    main:
        ;работаем с первым сегментом
        assume DS:FirsSeg
        mov ax, FirsSeg
        mov ds, ax

        mov bx, offset adress
        mov [bx+0], input_number
        mov [bx+2], output_hex
        mov [bx+4], str_to_2num
        mov [bx+6], exit

    menu:
        mov ah, 9
        mov dx , offset message
        int 21h

        mov AH,1 
        INT 21h
        mov cx, 0h 
        mov cl, 2
        sub al,30h
        sub al, 1
        mul cl
        mov ah, 0
        mov si, ax

        call print_new_line
        call [bx][si]
        call print_new_line

    jmp menu


        ;EXIT;
    exit proc near
        mov AH,4Ch
        INT 21h
    exit endp
    
Code ENDS
;END;

;RUN PROGRAMM;
END main
