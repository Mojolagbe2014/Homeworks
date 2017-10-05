//
//  CodeProfiling.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-04.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <stdio.h>
#include <iostream>
#include <time.h>
//#define RUN_SECTION

#ifdef RUN_SECTION
int main() {
    int n = 100000000;
    double d, dpi = 3.1415926535897932385;
    
    float f, fpi = 3.1415926535897932385;
    time_t tm0 = time(0);                   // wall time at this point
    clock_t ck0 = clock();                  // clock ticks at this point
    
    for(unsigned i = 0; i < n; i++) d = (double(i) + dpi) * dpi;
    
    time_t tm1 = time(0);                   // wall time at this point
    clock_t ck1 = clock();                  // clock ticks at this point
    
    std::cout << "Wall Time = " << difftime(tm1, tm0) << " seconds.\n";
    std::cout << "CPU time = " << (double)(ck1 - ck0) / CLOCKS_PER_SEC << " seconds.\n";
    
    
    for(unsigned i = 0; i < n; i++) f = (float(i) + fpi) * fpi;
    
    time_t tm2 = time(0);                   // wall time at this point
    clock_t ck2 = clock();                  // clock ticks at this point

    
    std::cout << "\nWall Time = " << difftime(tm2, tm1) << " seconds.\n";
    std::cout << "CPU time = " << (double)(ck2 - ck1) / CLOCKS_PER_SEC << " seconds.\n";
    
    std::cout << "\nThe current time is: " << ctime(&tm2) << '\n';

    return 0;
}
#endif
