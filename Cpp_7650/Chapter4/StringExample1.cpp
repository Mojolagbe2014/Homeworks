//
//  StringExample.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-09.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>
#include <string>
//#define RUN_SECTION

#ifdef RUN_SECTION
int main(int argc, const char * argv[]) {
    
    std::string s0;                     // empty string
    std::string s00 ="";                // empty string
    std::string sl ="Hello";            // initialization
    std::string s2 = "World";
    std::string s3 = s2;
    std::string s33(5,'A');             // 5 copies of 'A', s33 = "AAAAA"
    
    std::string s333 = 'A';             // error, no conversion from char
    std::string s3333 = 8;              // error, no conversion from int
    
    s3 = 'B';                           // OK, assign a char to string
    
    std::cout << s33 << '\n';
    
    return 0;
}
#endif
