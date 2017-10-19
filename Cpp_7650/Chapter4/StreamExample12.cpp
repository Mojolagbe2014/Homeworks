//
//  StringExample.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-09.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <fstream>
#include <sstream>
#include <string>
//#define RUN_SECTION

#ifdef RUN_SECTION
int main(int argc, const char * argv[]) {
    
    std::string s = "ex 5 - 9.9 h";
    std::istringstream ism(s); // initialize ism from string s
    int i;
    double d;
    std::string u, v, w;
    ism >> u >> i >> v >> d >> w; // i =5, d =9.9
    
    return 0;
}
#endif
