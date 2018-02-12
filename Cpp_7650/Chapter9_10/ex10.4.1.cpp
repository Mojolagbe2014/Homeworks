//
//  ex10.4.1.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-02-11.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//

//#define RUN_SECTION
#ifdef RUN_SECTION

#include <stdio.h>
#include <iostream>
#include <complex>
#include <vector>
#include <algorithm>
#include <stdlib.h>     /* srand, rand */
#include <time.h>       /* time */

bool reverseCompare(std::complex<double> a, std::complex<double> b) {
//    if (a.real() == b.real())
//        return a.imag() > b.imag();
//    return a.real() > b.real();
    return std::abs(a) > std::abs(b);
}

int main(){
    unsigned n = 10;
    std::vector<std::complex<double>> v(n);
    
    srand(time(NULL));
    for (int i = 0; i < n; i++){
        v[i] = std::complex<double>(rand() % 10 + 1, rand() % 8 + 1);
    }
    
    std::cout << "===== Before Sorting =====\n";
    for (int i = 0; i < n; i++) std::cout << v[i] << std::endl;
    
    sort(v.begin(), v.end(), reverseCompare); // sort in decreasing order
    
    std::cout << "\n===== After Sorting =====\n";
    for (int i = 0; i < n; i++) std::cout << v[i] << std::endl;
    
    return 0;
}

#endif
