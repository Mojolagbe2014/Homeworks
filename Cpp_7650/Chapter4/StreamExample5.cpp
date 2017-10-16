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
    double d = 12345.678987654321;
    
    std::cout.width(25);  // output width 25 chars
    std::cout.precision(15);
    std::cout << d << '\n';
    
    std::cout.width(25);  // output width 25 chars
    std::cout.precision(8);
    std::cout.fill('#'); // use # for padding extra space
    std::cout << d << '\n';
    
    std::cout.setf(std::ios_base::left, std::ios_base::adjustfield);
    std::cout.width(25);  // output width 25 chars
    std::cout.precision(15);
    std::cout << d << '\n';
    return 0;
}
#endif
