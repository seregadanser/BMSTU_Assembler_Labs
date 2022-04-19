PUBLIC str_to_16num 
PUBLIC output_hex

EXTRN buff: byte
EXTRN hexi: word


TmpSeg SEGMENT PARA 'DATA'
    htable db "0123456789ABCDEF"
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
    

output_hex proc near

    push ds 
    push es 
    push bx

    assume ES:TmpSeg
    mov ax, TmpSeg
    mov es, ax
    mov bx, offset htable

    assume DS:SEG hexi
    mov ax, SEG hexi
    mov ds, ax


    mov ax, hexi
    mov cl, 4    ; в СХ количество введенных символов
   ; mov cx, 
    push ax
    ls:
        pop ax
        rol ax, 1
        rol ax, 1
        rol ax, 1
        rol ax, 1
        push ax
        and al, 0Fh

        ;способ 1
        xlat htable

        ;способ 2
        ;cmp al, 0ah
        ;sbb al, 69h
        ;das
        
        mov dl, al;положили для вывода
        ;sub dl, 30h
        ;cmp dl, 00
        ;jne continue
        call output_symb
        
    loop ls

  ;  continue:
  ;      add dl, 30h
  ;      call output_symb
  ;      cmp cl, 00 
  ;      je out_e
  ;      dec cl
  ;      cmp cl, 00 
  ;      je out_e
  ;      
  ;  l2:
  ;      pop ax
  ;      rol ax, 1
  ;      rol ax, 1
  ;      rol ax, 1
  ;      rol ax, 1
  ;      push ax
  ;      and al, 0Fh
  ;      cmp al, 0ah 
  ;      sbb al, 69h
  ;      das
  ;      mov dl, al
  ;      call output_symb
  ;  loop l2

    out_e:
        pop ax

        pop bx
        pop es 
        pop ds 
        ret
output_hex endp

str_to_16num proc near
    push bx 
    push ax
    push si
    push di
    push ds

    assume DS:SEG buff
    mov ax, SEG buff
    mov ds, ax

    xor di, di
    mov hexi, 0h
    mov bx, offset buff+1 ; в BX адрес следующего элемента буфера
    mov cx, [bx]; в СХ количество введенных символов
    xor ch, ch
    mov si, 1; в SI множитель
    m1:    
        push si; сохраняем SI в стек
        mov si, cx; номер символа в SI
        mov ax, [bx][si] ; сохраняем текущий символ в AX  
        xor ah, ah 
        pop si; извлекаем SI из стека
        sub ax, 30h; получаем из символа цифру 
        mul si; умножаем цифру на множитель SI
        add word ptr [hexi], ax; прибавляем к результату
        ;add di, ax
        mov ax, si; помещаем множитель в AX
        mov dx, 10
        mul dx; увеличиваем его в 10 раз
        mov si, ax; помещаем обратно в SI
    loop m1; переходим к следующему символу

    pop ds
    pop di
    pop si
    pop ax
    pop bx

    ret
str_to_16num endp

Code ENDS

END