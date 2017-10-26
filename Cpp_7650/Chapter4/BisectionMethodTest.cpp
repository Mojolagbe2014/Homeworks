//
//  NewtonsMethod.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-09.
//

#include <iostream>
#include <math.h>
#include <stdlib.h>
#include "BisectionMethod.h"

//#define RUN_SECTION
#ifdef RUN_SECTION

using namespace NumericMethod;
int main(int argc, const char * argv[]) {
    
    // find a root of fa()
    double root = bisctn0(0.1, 1.0, fa, delta, epsn);
    std::cout << "Approximate root of fa() by bisctn0() is: " << root << '\n';
    std::cout << "Fcn value at approx root (residual) is: " << fa(root) << '\n';
    
    // find a root of fb()
    root = bisctn0(1, 3, fb, delta, epsn);
    std::cout << "\nApproximate root of fb() by bisctn0() is: " << root << '\n';
    std::cout << "Fcn value at approx root (residual) is: " << fb(root) << '\n';
    
    // find a root of fc()
    root = bisctn0(0, 4, fc, delta, epsn);
    std::cout << "\nApproximate root of fc() by bisctn0() is: " << root << '\n';
    std::cout << "Fcn value at approx root (residual) is:" << fc(root) << '\n';
    
    return 0;
}
#endif
