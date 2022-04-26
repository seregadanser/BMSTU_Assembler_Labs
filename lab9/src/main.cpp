#include <iostream>
#include <cmath>
#include "../inc/sub.hpp"
#include "../inc/mul.hpp"

double load_asm_pi()
{
    double pi;
    asm(
        "fldpi\n\t"
        "fstp %0\n\t"
    : "=m" (pi)
    );
    return pi;
}

double load_asm_pi2()
{
    double pi;
    double k = 2;
    asm(
        "fld %1\n\t"
        "fldpi \n\t"
        "fdivrp st(1), st(0) \n\t"
        "fstp %0\n\t"
    : "=m" (pi)
    :"m" (k)
    );
    return pi;
}

int main(int argc, char const *argv[])
{
    float fa, fb;
    double da, db;
    long double lda, ldb;
    lda = da = fa = (double)rand() / RAND_MAX + 1;
    ldb = db = fb = (double)rand() / RAND_MAX + 1;
    std::cout<<"\nadd time\n";
    std::cout<<"----------------------------\n";
    std::cout<<"c++ time: "<<sub_float(fa, fb)<<'|'<<sub_double(da, db)<<'|'<<sub_long(lda, ldb)<<'\n';
    std::cout<<"asm time: "<<sub_asm_float(fa, fb)<<'|'<<sub_asm_double(da, db)<<'|'<<sub_asm_long(lda, ldb)<<'\n';
    std::cout<<"\nmul time\n";
    std::cout<<"----------------------------\n";
    std::cout<<"c++ time: "<<sub_float(fa, fb)<<'|'<<sub_double(da, db)<<'|'<<sub_long(lda, ldb)<<'\n';
    std::cout<<"asm time: "<<sub_asm_float(fa, fb)<<'|'<<sub_asm_double(da, db)<<'|'<<sub_asm_long(lda, ldb)<<'\n';
    std::cout<<"pi 3.14: "<<sin(3.14)<<"| pi 3.141596: "<<sin(3.141596)<<"| load asm pi: "<<sin(load_asm_pi())<<'\n';
    std::cout<<"pi 3.14/2: "<<sin(3.14/2)<<"| pi 3.141596/2: "<<sin(3.141596/2)<<"| load asm pi/2: "<<sin(load_asm_pi2());
    return 0;
}
