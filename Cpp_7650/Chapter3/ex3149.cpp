//
//  ex31410.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>

//#define RUN_SECTION
#ifdef RUN_SECTION

int main(int argc, const char * argv[]){
    unsigned n = 10;
    unsigned total = n*2 + 1;
    double* s = new double[total];
    
    for(int val = -n, i = 0; i <= total; ++val, i++) s[i] = val; //s[i] = (val == 0) ? ++val : val;
    
    for(unsigned i = 0; i < total; i++) std::cout << s[i] << std::endl;
    
    delete[] s;
    
    return 0;
}
#endif
