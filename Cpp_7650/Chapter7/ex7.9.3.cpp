//
//  ex7.9.3.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-02-08.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//
//#define RUN_SECTION
#ifdef RUN_SECTION

#include <stdio.h>
#include <iostream>
#include "Vcr.cpp"
#include "Mtx.cpp"

int main(){
    int k = 4;              // set matrix size
    double** mt = new double*[k];
    
    for (int i = 0; i < k; i++) mt[i] = new double [k];
    
    for (int i = 0; i < k; i++)
        for(int j=0; j<k; j++)
            mt[i][j] = 1; // 2*i*j+i+10
    
    
    Mtx<double> m1(k, k, mt);
    Mtx<double> m2(k, k, 2.); // 5.
    Mtx<double> m3(k, k);
    
    for (int i = 0; i < k; i++)         // update entries of m3
        for (int j = 0; j < k; j++)
            m3[i][j] = 3.0;  // 1/(2*i + j + 5.7)
    
    std::cout << "Before Arithmetic Operations" << std::endl;
    std::cout << m1 << std::endl << m2 << std::endl << m3 << std::endl;
    
    
    
    m3 += -m1 + m2;                     // resemble mathematics
    m1 -= m3;                           // very readable
    
    std::cout << "\nAfter Arithmetic Operations\n";
    std::cout << m1 << std::endl << m2 << std::endl << m3 << std::endl;
    
    Vcr<double> vv(k);
    for(int i = 0; i < k; i++) vv[i] = 1.; // 5*i + 3
    
    vv = m3*vv;                         // resemble mathematics
    
    std::cout << "\nMatrix Vector Product\n";
    std::cout << vv << std::endl;
    
    return 0;
}


#endif
