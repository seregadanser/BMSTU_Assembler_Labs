#include <iostream>

extern "C"
{
	void testAsm(char *dst, char *src, int len);
}

int str_len(const char* str)
{
	int len = 0;
	__asm
	{
		mov edi, str
		mov esi, edi
		xor eax, eax
		mov ecx, 0ffffffffh
		repne scasb
		sub edi, esi
		dec edi
		mov len, edi
	}
	return len;
}

int main()
{
	char a[100] = "abd";
	char *b = a;
	printf("%d",str_len(a));
	int len = str_len(a);
	testAsm(b, a, len);
	printf("%s", b);
}