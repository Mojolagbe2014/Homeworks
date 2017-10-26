//
//  ex3146.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>
#include <math.h>

//#define RUN_SECTION
#ifdef RUN_SECTION
double sqroot(unsigned);

int main(int argc, const char * argv[]){
    
    std::cout << "Please supply any integer number = ";
    
    unsigned input;
    std::cin >> input;
    
    //std::cout.width(32);
    std::cout.precision(32);
    std::cout << std::endl << " Square Root Cus = " << sqroot(input) << '\n';
    
    //std::cout.width(32);
    std::cout.precision(32);
    std::cout << " Square Root C++ = " << sqrt(input) << std::endl << std::endl;
    
    return 0;
}


double sqroot(unsigned b){
    
    double x = 1.;
    
    for(unsigned n = 1; n <= b; n++)
        x = 0.5*(x + (b/x));
    
    return x;
}
#endif
