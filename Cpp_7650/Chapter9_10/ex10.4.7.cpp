//
//  ex10.4.7.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-02-11.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//
#define RUN_SECTION
#ifdef RUN_SECTION

#include <iostream>
#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <vector>


template<typename T> T onenorm(const std::vector<T>& vr) {     // 1 - norm
    T norm;
    
    // for_each with lambda function
    std::for_each(vr.begin(), vr.end(), [&norm](const T& n) mutable -> T {
        norm += std::abs(n);
        return norm;
    });
    
    return (norm);
}

template<typename T> T twonorm(const std::vector<T>& vr) {     // 2 - norm
    T norm;
    
    // for_each with lambda function
    std::for_each(vr.begin(), vr.end(), [&norm](const T& n) mutable -> T {
        norm += n*n;
        return norm;
    });
    
    return sqrt(norm);
}


template<typename T> T maxnorm(const std::vector<T>& vr) {    // maximum norm
    T nm = std::abs(vr[0]);
    
    // for_each with lambda function
    std::for_each(vr.begin(), vr.end(), [&nm](const T& n) mutable -> T {
        nm = std::max(nm, std::abs(n));
        return nm;
    });
    
    return nm;
}

int main() {
    std::vector<double> nums{3.26, 4.89, 2.01, 8.984, 15.122, 267.102};
    
    std::cout << "1 - Norm = " << onenorm(nums) << std::endl;
    std::cout << "2 - Norm = " << twonorm(nums) << std::endl;
    std::cout << "Inf-Norm = " << maxnorm(nums) << std::endl;
    
    return 0;
}

#endif
