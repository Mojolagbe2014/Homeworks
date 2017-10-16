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
    std::cout << i << " " << i << '\n'; // decimal
    
    std::cout.setf(std::ios_base::oct, std::ios_base::basefield); // octal
    std::cout << i <<" " << i << '\n'; //print i in octal
    
    std::cout.setf(std::ios_base::hex , std::ios_base::basefield); // hex
    std::cout << i <<" " << i << '\n'; //print i in hex
    
    std::cout.setf(std::ios_base::dec, std::ios_base::basefield); // decimal ;
    std::cout << i <<" " << i << '\n'; //print i in decimal
    
    return 0;
}
#endif
