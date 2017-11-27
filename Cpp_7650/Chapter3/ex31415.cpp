//
//  ex31415.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>

//#define RUN_SECTION
#ifdef RUN_SECTION

long fibonacci(int n){
    long fp = 1; // previous Fibonacci number
    long fc = 1; // current Fibonacci number
    unsigned itr = 2;
    
    for (int i = 3; i <= n; i++) { // main loop
        long tmp = fc;                                      //temporary storage
        fc += fp;                                           //update Fib number
        fp = tmp;                                           //store previous Fib number
        itr++;
    }
    
    std::cout << "Total Iteration(s) = " << itr << std::endl;
    
    return fc;
}

long fibonacci(int n, int& itr, long& fp, long& fc){
    std::cout << fp << std::endl;
    long temp = fc + fp;
    fp = fc;
    fc = temp;
    
    --n; ++itr;
    
    if(n > 0) fibonacci(n, itr, fp, fc);
    
    return fp;
}

int main(int argc, const char * argv[]){
//    int n = 40;
//    long fib = fibonacci(n);
//    std::cout << "Fibonacci("<< n << ") = " << fib << std::endl;
    
    int n = 40, itr = 2; long fp = 1, fc = 1;
    long fib = fibonacci(n - 1, itr, fp, fc);
    std::cout << "Fibonacci("<< n << ") = " << fib << std::endl;
    
    return 0;
}
#endif
