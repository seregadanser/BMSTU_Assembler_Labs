#pragma once
#include <time.h>
#include <stdio.h>
#include <stdlib.h>

#define ITERATIONS 100000000
double mul_float(float fa, float fb);
double mul_double(double da, double db);
double mul_long(long double lda,long double ldb);
double mul_asm_float(float fa, float fb);
double mul_asm_double(double da, double db);
double mul_asm_long(long double lda,long double ldb);