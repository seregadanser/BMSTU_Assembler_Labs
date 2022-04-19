masm to_hex.asm
masm to_dou.asm
masm input.asm 
masm main.asm 
echo Link
link  main.obj input.obj to_hex.obj to_dou.obj ,,,,,
