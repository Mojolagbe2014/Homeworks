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
    double d = 12345.6789;
    std::cout << d << " " << d << '\n'; // default
    
    std::cout.setf(std::ios_base::scientific, std::ios_base::floatfield);  // show base of output
    std::cout << d << " " << d << '\n'; // scientific
    
    std::cout.setf(std::ios_base::fixed, std::ios_base::floatfield);
    std::cout << d <<" " << d << '\n'; //fixed
    
    std::cout.setf(0, std::ios_base::floatfield); // reset to default
    
    return 0;
}
#endif
