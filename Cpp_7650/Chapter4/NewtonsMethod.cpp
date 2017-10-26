//
//  BisectionMethodTest.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-09.
//

#include <iostream>
#include <math.h>
#include <stdlib.h>

//#define RUN_SECTION
#ifdef RUN_SECTION

typedef double (*pfn)(double); // define a function type

double newton(double xp, pfn f, pfn fd, double delta, double epsn, int mxt) {
    double v = f(xp) ;  // fcn value at initial guess
    double xnew;        // store new iterate
    
    for (int k = 1; k <= mxt; k++) { // main iteration loop
        double derv = fd(xp); // derivative at xp
        if (!derv) {
            std::cout << "Division by 0 occurred in newtonO .\n" ;
            exit(1) ;       // stop if divisor == 0
        }
        xnew = xp - v/derv;         // compute new iterate
        v = f(xnew);                // fcn value at new iterate
        
        if (fabs(xnew - xp) < delta || fabs(v) < epsn) return xnew; xp = xnew;
    } // end main iteration loop
    return xnew;
}

double f(double x) { return ((x - 5)*x + 3)*x + 7; }
double fder(double x) { return (3*x - 10)*x + 3; }

int main(int argc, const char * argv[]) {
    
    // find a root of fa()
    double root = newton(5, f, fder, 1.0e-8, 1.0e-9, 500);
    std::cout << "Approx root near 5 by newton method is: " << root << '\n';
    std::cout << "Fcn value at approx root (residual) is: " << f(root) << '\n';
    return 0;
}
#endif
