//
//  ex7.9.15.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-02-08.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//
#define RUN_SECTION
#ifdef RUN_SECTION


#include <stdio.h>
#include <iostream>
#include "Vcr.cpp"
#include "Mtx.cpp"

using namespace std;

int main() {
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
    
    // Real Matrix
//    int n = 300;
//    Mtx<double> a(n, n);                            // n by n Hilbert matrix
//    
//    for (int i = 0; i < n; i++)
//        for (int j = 0; j < n; j++)
//            a[i][j] = 1/(i + j + 1.0);
//    
//    Vcr<double> t(n);                               // exact solution vector of size n
//    Vcr<double> x(n);                               // initial guess and solution vector
//    
//    for (int i = 0; i < n; i++)                     // true solution
//        t[i] = 1/(i + 3.14);
//    
//    int iter = 300;
//    double eps = 1.0e-9;
//    
//    int ret = a.CG(x, a*t, eps, iter);              // call CG algorithm
//    
//    if (ret == 0) cout << "CG returned successfully\n";
//    cout << iter << " iterations are used in CG method.\n";
//    cout << "Residual = " << eps << ".\n";
//    cout << "Two-norm of exact error vector = " << (x - t).twonorm() << '\n';


    // Complex Matrix
    int n = 300;
    Mtx<complex<double>> a(n, n);                            // n by n Hilbert matrix
    
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            a[i][j] = 1/(i + j + 1.0);
    
    Vcr<complex<double>> t(n);                               // exact solution vector of size n
    Vcr<complex<double>> x(n);                               // initial guess and solution vector

    for (int i = 0; i < n; i++)                     // true solution
        t[i] = 1/(i + 3.14);
    
    int iter = 300;
    double eps = 1.0e-9;

    int ret = a.CG(x, a*t, eps, iter);              // call CG algorithm
    if (ret == 0) cout << "CG returned successfully\n";
    cout << iter << " iterations are used in CG method.\n";
    cout << "Residual = " << eps << ".\n";
    cout << "Two-norm of exact error vector = " << (x - t).twonorm() << '\n';
    
    
    return 0;
}

#endif
