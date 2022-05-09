#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <iostream>

float scalar_mlt(float a[], float b[], size_t size)
{
    float res = 0;
    for (size_t i = 0; i < size; i++)
        res += a[i] * b[i];

    return res;
}

void memcpy_null(float* a, float* b, size_t need, size_t have)
{
    int i = 0;
    while (i < have && i < need)
    {
        a[i] = b[i];
        i++;
    }
    while (i < need)
    {
        a[i] = 0;
        i++;
    }
}

float scalar_mlt_asm(float* a, float* b, size_t size)
{
    float res = 0;
    float a_buf[4];
    float b_buf[4];
    float res_buf[4];
    float tmp = 0;


    for (size_t i = 0; i < size; i += 4)
    {
        memcpy_null(a_buf, a, 4, (size - i));
        memcpy_null(b_buf, b, 4, (size - i));
        __asm
        {
            movups xmm0, a_buf
            movups xmm1, b_buf
            mulps xmm0, xmm1
            haddps xmm0, xmm0
            haddps xmm0, xmm0
            movss tmp, xmm0
        }
        //for (size_t i = 0; i < 4; i++)
        res += tmp;
        a += 4;
        b += 4;
    }

    return res;
}

int main()
{
    float a[5] = { 1.0, 2.0, 3.0, 4.0, 5.0 };
    float b[5] = { 1.0, 2.0, 3.0, 4.0 , 5.0 };
    float res_asm = scalar_mlt_asm(a, a, 5);
    float res = scalar_mlt(a, a, 5);
    printf("res asm - %f\n", res_asm);
    printf("res - %f\n", res);
}
