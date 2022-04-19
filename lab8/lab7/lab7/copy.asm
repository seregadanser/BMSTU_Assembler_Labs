.686
.MODEL FLAT, C
.STACK

.CODE

testAsm PROC C to:dword, from:dword, len:dword
	mov	esi, from
	mov	edi, to
	mov ecx, len
	mov eax, esi
	add eax, ecx
	cmp eax, edi
	jnl change
	jmp not_change

change:
	std
	add esi, ecx
	add edi, ecx
	dec esi
	dec edi
	jmp exit
not_change:
	cld
	jmp exit
exit:
	rep movsb
	cld
	ret
testAsm ENDP

END
