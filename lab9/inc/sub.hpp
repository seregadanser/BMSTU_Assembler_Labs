#pragma once
#include <time.h>
#include <stdio.h>
#include <stdlib.h>

#define ITERATIONS 100000000
double sub_float(float fa, float fb);
double sub_double(double da, double db);
double sub_long(long double lda,long double ldb);
double sub_asm_float(float fa, float fb);
double sub_asm_double(double da, double db);
double sub_asm_long(long double lda,long double ldb);