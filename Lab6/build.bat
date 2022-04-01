masm to_hex.asm
masm input.asm 
masm main.asm 
echo Link
link  main.obj input.obj to_hex.obj ,,,,,
