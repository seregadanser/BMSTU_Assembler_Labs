SSTK SEGMENT PARA STACK 'STACK'
	db 100 dup(0); стек 100 байт инициализированных 0
SSTK ENDS

FirsSeg SEGMENT PARA 'DATA'
    matrix db 81 dup(0); массив из 81 байт инициализированных 0
    max_n db 1 dup(9)
    max_m db 1 dup(9)
    n db 1 dup(0)
    m db 1 dup(0)
    i db 1 dup(0)
    j db 1 dup(0)
    s1 dw 1
    s2 dw 1
FirsSeg ENDS

Code SEGMENT PARA 'CODE'
    assume CS:Code
    endline proc
        push ax
        push dx
        mov ah, 2
        mov dl, 13
        int 21h
        mov dl, 10
        int 21h
        pop dx 
        pop ax 
        ret
    endline endp

    spaceq proc
        push ax
        mov ah, 2
        mov dl, 32
        int 21h
        pop ax
        ret
    spaceq endp

    output_m proc
        mov DS:i, 0
        push bp
        mov bp,sp
        mov cx, 0h
        mov cl, [bp+6]
        loop_i_o:
            push cx
            mov DS:j, 0
            mov cx, 0h
            mov cl, [bp+8]
            loop_j_o:
                mov ax, 0h
                mov al, DS:i
                mov bx, 0h
                mov bl, DS:max_m
                mul bx
                add al, DS:j
                mov bx, ax
                add bx, [bp+4]
                mov dl, [bx]
                add dl, 30h
                mov AH,2 
                INT 21h
                mov dl, 32
                int 21h
                inc DS:j
            loop loop_j_o
            call endline
            pop cx
            inc DS:i
        loop loop_i_o
        pop bp
        ret
    output_m endp


    ;START;
    main:
        ;работаем с первым сегментом
        assume DS:FirsSeg
        mov ax, FirsSeg
        mov ds, ax

        ;ввод n
        mov AH,1 
        INT 21h
        sub al,30h
        mov n,al

        call spaceq

        ;ввод m
        mov AH,1 
        INT 21h
        sub al,30h
        mov m,al 

        call endline
        
        mov bp, offset matrix
        
        mov cx, 0h
        mov cl, n
        loop_i:
            push cx
            mov j, 0
            mov ax, 0h
            mov cx, 0h
            mov cl, m
            loop_j:
                mov AH,1 
                INT 21h
                sub al,30h
                push ax
                mov ax, 0h
                mov al, i
                mov bx, 0h
                mov bl, max_m
                mul bx
                add al, j
                mov bx, ax
                pop ax
                call spaceq
                mov matrix[bx],al 
                inc j
            loop loop_j
            call endline
            pop cx
            inc i
        loop loop_i

        call endline

        

        mov cx, 0h
        mov ax, 0h
        mov bx, 0h
        
        ;цикл по столбцам
        mov al, m
        mov bl, 2
        div bl
        mov cl, al
        mov j, 0;
        loop_i1:
            push cx;
            ; цикл по строкам
            mov i, 0
            mov ax, 0h
            mov cx, 0h
            mov cl, n
            loop_j1:
                ;нахождение первого адреса и помещение его в s1
                ;i*max_m+j
                mov ax, 0h
                mov al, i
                mov bx, 0h
                mov bl, max_m
                mul bx
                add al, j
                mov s1, bp
                add s1, ax                
                ;нахождение второго адреса и помещение его в s2 
                ; i*max_m+m-1-j
                mov ax, 0h
                mov al, i
                mov bx, 0h
                mov bl, max_m
                mul bx
                mov bl, m
                sub bl, j
                sub bl, 1
                add al, bl
                mov s2, bp
                add s2, ax
                ;смена значений
                mov bx, s1; в bx заносим адрес первой переменной
                mov ax, 0h
                mov al, [bx]; в al заносим значение первой переменной
                push ax; сохраняем значение в стеке

                mov bx, s2; в bx заносим адрес второй переменной
                mov ax, 0h
                mov al, [bx]; в al заносим значение второй переменной

                mov bx, s1 ; в bx заносим адрес первой переменной
                mov [bx], al;помещаем в первую переменную значение второй

                mov bx, s2; в bx заносим адрес второй переменной
                pop ax ; получаем значение первой переменной из стека
                mov [bx], al;помещаем во вторую переменную значение первой

                inc i
            loop loop_j1
            pop cx
            inc j
        loop loop_i1

        ;внесение параметров в стек для вызова функции вывода матрицы
        ;помещение m
        mov ax, 0h
        mov al, m
        push ax
        ;помещение n
        mov ax, 0h
        mov al, n
        push ax
        ;помещение указателя на матрицу
        mov ax, 0h
        mov ax, offset matrix
        push ax
        ;output_m(int *matrix, int n, int m)
        ;вызов функции вывода матрицы
        call output_m
        ;очиста стека
        pop ax
        pop ax 
        pop ax

        ;EXIT;
        mov AH,4Ch
        INT 21h
Code ENDS
;END;

;RUN PROGRAMM;
END main
