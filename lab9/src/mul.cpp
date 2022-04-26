#include "../inc/mul.hpp"
#pragma region c++
double mul_float(float fa, float fb)
{
    float fc;
    time_t start = clock();

    for (int i = 0; i < ITERATIONS; i++)
        fc = fa*fb;

  time_t stop = clock();

  return (double)(stop - start) / CLOCKS_PER_SEC;
}

double mul_double(double da, double db)
{
    double dc;
    time_t start = clock();

    for (int i = 0; i < ITERATIONS; i++)
        dc = da*db;

  time_t stop = clock();

  return (double)(stop - start) / CLOCKS_PER_SEC;
}

double mul_long(long double lda,long double ldb)
{
    long double ldc;
    time_t start = clock();

    for (int i = 0; i < ITERATIONS; i++)
        ldc = lda*ldb;

  time_t stop = clock();

  return (double)(stop - start) / CLOCKS_PER_SEC;
}
#pragma endregion
#pragma region asm
double mul_asm_float(float fa, float fb)
{
    float fc;
    time_t start = clock();

    for (int i = 0; i < ITERATIONS; i++)
      asm(
        "fld %1\n\t"
        "fld %2\n\t"
        "fmulp st(1), st(0)\n\t"
        "fstp %0\n\t"
        : "=m" (fc)
        : "m" (fa), "m" (fb)
      );

  time_t stop = clock();

  return (double)(stop - start) / CLOCKS_PER_SEC;
}

double mul_asm_double(double da, double db)
{
    double dc;
    time_t start = clock();

    for (int i = 0; i < ITERATIONS; i++)
       asm(
        "fld %1\n\t"
        "fld %2\n\t"
        "fmulp st(1), st(0)\n\t"
        "fstp %0\n\t"
        : "=m" (dc)
        : "m" (da), "m" (db)
      );

  time_t stop = clock();

  return (double)(stop - start) / CLOCKS_PER_SEC;
}

double mul_asm_long(long double lda,long double ldb)
{
    long double ldc;
    time_t start = clock();

    for (int i = 0; i < ITERATIONS; i++)
       asm(
        "fld %1\n\t"
        "fld %2\n\t"
        "fmulp st(1), st(0)\n\t"
        "fstp %0\n\t"
        : "=m" (ldc)
        : "m" (lda), "m" (ldb)
      );

  time_t stop = clock();

  return (double)(stop - start) / CLOCKS_PER_SEC;
}
#pragma endregion