//  ex7.9.1.cpp
//  Cpp4Engineers

//#define RUN_SECTION
#ifdef RUN_SECTION

#include <stdio.h>
#include <iostream>
#include <cmath>
#include "Vcr.cpp"

using namespace std;

int main(int argc, char* argv[]){
    
    //    int n = 4;
    //    complex<double>* aa = new complex<double>[n];
    //
    //    for (int j = 0; j < n; j++) aa[j] = complex<double>(5, j);
    //    Vcr<complex<double>> v1(n, aa);                     // vector v1
    //
    //    Vcr<complex<double>> v2(n), v3(n);                         // vector v2
    //    for (int j = 0; j < n; j++) v2[j] = complex<double> (2, 3+j);
    //
    //    v3 += v2 - v1;
    //    std::cout << "Before Arithmetic Operations" << std::endl;
    //    std::cout << v1 << std::endl << v2 << std::endl;
    //
    //    cout << "norm = " << v1.maxnorm() << '\n';          // max norm
    //    cout << "dot = " << dot(v1,v2) << '\n';              // dot product

    Vcr<float> fv(4, 2.);
    Vcr<double> dv(3, 2.);
    Vcr<double> dv2(3, 3.);
    
    dv += dv2;
    Vcr<double> dv3 = dv; // note dv3 here has updated value of dv
    
    dv3 = dv/2.;
    
    std::cout << "dv += dv2 = \n" << dv << std::endl;
    std::cout << "dv * 3. = \n" << dv2 * 3. << std::endl;
    std::cout << "dv3 = dv/2. = \n" << dv3 << std::endl;
    
    std::cout << "fv * fv = \n" << fv * fv << std::endl;
    std::cout << "dv3.twonorm() = " << dv3.twonorm() << std::endl;
    std::cout << "dot(dv, dv2)  = " << dot(dv, dv2) << "\n\n";
    
    return 0;
}
#endif
