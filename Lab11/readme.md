Основываясь на примерах MASM32 написать собственное оконное приложение

Не уверен, что все файлы тут нужны но пусть будут.

Я использовал пример gettext.asm и сайт https://www.masm32.com/board/index.php?topic=4741.0

Виджеты определяются с 66 строки. Просьба быть внимательными при изменении количества элементов управления и следить, чтобы их количество совпадало с 63 строкой. 

При объявлении элементов управления последнее число отвечает за код команды. При нажатии на элемент управления со строки 107 происходит обработка действий по командам.

со строки 84 объявляем локальные переменные на стеке

Обработка действий происходит с 105 строки

функция invoke atol переводит строковый буффер в число, результат лежит в eax

функция invoke wsprintf переводит число в строку
