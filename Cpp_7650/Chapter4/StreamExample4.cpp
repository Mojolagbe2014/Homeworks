//
//  StringExample.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-09.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>
#include <stdio.h>
//#define RUN_SECTION

#ifdef RUN_SECTION
int main(int argc, const char * argv[]) {
    double d = 12345.67890123456789;
    std::cout << d << " " << d << '\n'; // default
    
    std::cout.setf(std::ios_base::scientific, std::ios_base::floatfield);
    std::cout.setf(std::ios_base::uppercase);  // E in scientific format
    std::cout.precision(15); // precision = 15
    std::cout << d <<" " << 1000 * d << '\n';
    
    std::cout.precision(10); // precision = 10
    std::cout << d <<" " << 1000 * d << '\n';
    
    return 0;
}
#endif
