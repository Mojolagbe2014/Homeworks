//
//  fibonacci.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-20.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>

//#define RUN_SECTION
#ifdef RUN_SECTION

int main(int argc, const char * argv[]){
    
    long fp = 1; // previous Fibonacci number
    long fc = 1; // current Fibonacci number
    
    for (int n = 2; n <= 6; n++) { // main loop
        std::cout << n << " ";
        std::cout << fc << " ";                             // output fibonacci number
        
        std::cout << (long double)fc/fp << std::endl;       // output fibonacci quotient
        
        long tmp = fc;                                      //temporary storage
        fc += fp;                                           //update Fib number
        fp = tmp;                                           //store previous Fib number
    }
    
    return 0;
}
#endif
