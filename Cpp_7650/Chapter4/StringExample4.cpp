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
    std::string s1 ="Hello";            // initialization
    std::string s2 = "World";
    std::string s3 = s2;
    std::string s33(5,'A');             // 5 copies of 'A', s33 = "AAAAA"
    
    if(s2 == s1){   // test fo equality of s1,s2
        s2 += '\n'; // append '\n' to end of s2
    }
    else if(s2 == "World"){
        s3 = s1 + ", " + s2 + "!\n"; // s3 = "Hello, World!\n"
    }
    
    s3[12] = '?';       //assign '?' to s3[12]
    
    // now s3 = "Hello, World?\n"
    const char* p = s3.c_str();         // convert to C-style string
    const char* q = s3.data();          // convert to an array of chars
    char c = q[0];                      // c = first character in q
    
    char* s6 = "Hello";
    std::string s7 = s6;                // from C-style string to string

    std::cout << &s3[0]  << '\n';
    std::cout << s6  << '\n';
    
    return 0;
}
#endif
