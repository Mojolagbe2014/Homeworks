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
    
    std::string s0;
    std::cout << "Enter your name\n";
    std::getline(std::cin, s0);           //read a whole line from cin
    std::cout << "Hi, " << s0 << "!\n";
    
    return 0;
}
#endif
