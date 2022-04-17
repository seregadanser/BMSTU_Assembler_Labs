#include <stdio.h>
#include <iostream>

int main()
{
	std::string str = "abs$";
	const char* str1 = str.c_str();
	__asm
	{
		mov edx, str1
	}
}