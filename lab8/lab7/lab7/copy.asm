.686
.MODEL FLAT, C
.STACK

.CODE

testAsm PROC C to:dword, from:dword, len:dword
	mov	esi, from
	mov	edi, to
	mov ecx, len
	cld
	rep movsb
	ret
testAsm ENDP
END