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
    char h = s3[12];    // h = ?
    
    int i = s3.length();     // size of s3, i = 14
    int j = s3.size();       // size of s3, j = 14
    
    return 0;
}
#endif
