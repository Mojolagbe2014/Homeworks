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
    std::string s4 = s3.substr(7,5);        // s4 ="World";
    s3.replace(0,5,"Hi");                   // s3 = "Hi, World?"
    s3.insert(0,"Hi");                      // insert "Hi" at s3[0]
    
    unsigned int pos = s3.find("Wor");      // find position of substring "Wor"
    unsigned int pos2 = s3.find("HW");      // pos2 = 4294967295 on one machine
    s3.erase(0,2) ;                         // erase two characters from s3

    std::cout << s3 << '\n';
    
    return 0;
}
#endif
