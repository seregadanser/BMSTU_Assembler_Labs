Code SEGMENT PARA PUBLIC 'CODE'
    assume CS:Code, DS:Code
    org 100h
    ;jmp init
    old_int_handler dd 0
    local_counter db 0
    local_factor db ?;задержка
    speed db ?  

    Input PROC far
        push ax
        push bx
        push cx
        push dx
        push es
        push di

        pushf
        call cs:old_int_handler;вызов старого обработчика

        mov bl, cs:local_counter
        cmp bl, cs:local_factor

        jb exit1

        mov byte ptr cs:local_counter,0

            ;CODE;
            ;mov dl, 32h
            ;mov ah, 2
            ;int 21h
            ;обновляем скорость;
            mov al, 0f3h
            out 60h, al
            mov al, cs:speed
            out 60h, al

            ;меняем скорость;
            dec cs:speed
            test cs:speed, 00000000b
            jnz reset
            jmp exit
            reset:
                or cs:speed, 00001111b
            jmp exit

        exit1:
        inc bl
        mov byte ptr cs:local_counter, bl
    
    exit:
        pop di; вытащить из стека в обратном порядке
        pop es
        pop dx
        pop cx
        pop bx
        pop ax
        iret
    Input ENDP

    ;START;
    init:
        cli
        mov byte ptr local_factor, 17
        mov byte ptr speed, 1fh

        mov al, 0f3h
        out 60h, al
        in al, 60h
        mov cs:speed, al
        or cs:speed, 00001111b
        mov al, cs:speed
        out 60h, al
        

        mov ax,351ch
        int 21h
        mov word ptr old_int_handler, bx
        mov word ptr old_int_handler + 2, es
        
        mov ax,251ch    ; установить вектор прерывания
        mov dx,OFFSET Input
        int 21H
        
        mov ax,3100h   ; завершиться и остаться резидентным
        mov dx,OFFSET init
        sti
        int 21H

Code ENDS

;RUN PROGRAMM;
END init
