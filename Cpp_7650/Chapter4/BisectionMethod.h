//
//  BisectionMethod.h
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-18.
//

#ifndef BisectionMethod_h
#define BisectionMethod_h
#include <iostream> 
#include <math.h> 
#include <stdlib.h>

namespace NumericMethod {
    const double delta = 1.0e-8;
    const double epsn = 1.0e-9;
    
    double bisctn0(double, double, double (*)(double), double, double);
    double fa(double x);
    double fb(double x);
    double fc(double x);
    
    double bisctn1(double, double, double (*)(double), double, double, double);
    double bisctn2(double, double, double (*)(double), double, double, double, int);
    double bisctn3(double, double, double (*)(double), double, double, double, int, int&);
}
#endif /* BisectionMethod_h */
