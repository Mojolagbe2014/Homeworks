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
    int i = 123456789;
    
    std::cout.setf(std::ios_base::showbase);  // show base of output
    std::cout << i << " " << i << '\n'; // decimal, default
    
    std::cout.setf(std::ios_base::oct, std::ios_base::basefield);
    std::cout << i <<" " << i << '\n'; //octal, base 8
    
    std::cout.setf(std::ios_base::hex , std::ios_base::basefield);
    std::cout << i <<" " << i << '\n'; // hex, base 16
    
    std::cout.setf(0, std::ios_base::basefield); // reset to default
    std::cout << i <<" " << i << '\n'; //print i in decimal
    
    return 0;
}
#endif
