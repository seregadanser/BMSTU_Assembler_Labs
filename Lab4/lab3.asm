
SSTK SEGMENT PARA STACK 'STACK'
	db 100 dup(0); стек 100 байт инициализированных 0
SSTK ENDS

FirsSeg SEGMENT PARA 'DATA'
    arr db 10 dup(0); массив из 10 байт инициализированных 0
FirsSeg ENDS

SecondSeg SEGMENT PARA 'DATA'
    strout db 'Res: $' ;строка вывода
    result db 2 dup(0); два байта второго сегмента
SecondSeg ENDS


Code SEGMENT PARA 'CODE'
    assume CS:Code

    endline proc
        mov ah, 2
        mov dl, 13
        int 21h
        mov dl, 10
        int 21h
        ret
    endline endp

    output_symb proc
        mov ah, 2
        int 21h
        ret
    output_symb endp

    output_str proc
        push bp
        mov bp,sp
        mov ah, 9
        mov dx, [bp+4]
        int 21h
        pop bp
        ret
    output_str endp

    ;START;
    main:
        ;Записываем в dx первый сегмент. Работем с ним;
        assume DS:FirsSeg
        mov ax, FirsSeg
        mov ds, ax

        mov cx,9
        mov si,0
        go:
            mov AH,1 
            INT 21h
            sub al,30h
            mov arr[si],al 
            inc si 
        loop go

        mov ax, 0h; обнуляем регистр
        mov al, arr[1];прибавляем 2 элемент 
        add al, arr[4];прибавляем 5 элемент 
        add al, 30h;переводим число в символ 
        push ax;заносим итоговый результат в стек

        ;Записываем в dx второй сегмент. Работем с ним;
        assume DS:SecondSeg
        mov ax, SecondSeg
        mov ds, ax

        pop ax

        mov bx , OFFSET result
        mov [bx+1], ax 

        call endline;перенос строки

        mov dx, OFFSET strout; помещение указателя строки в dx
        push dx; помещение dx в стек
        call output_str ;вызов функции вывода строки 
        pop dx ;очищение стека(во славу cdecl)

        mov dl, [bx+1];кладем второй байт в dl
        call output_symb;выводим символ

        
        mov AH,4Ch
        INT 21h
Code ENDS
;END;

;RUN PROGRAMM;
END main
