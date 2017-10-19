//
//  BisectionMethod.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-09.
//

#include "BisectionMethod.h" // include header file

namespace NumericMethod {
    
    double bisctn0(double a, double b, double (*f)(double) , double delta, double epsn) {
        double c = (a + b)*0.5; // middle point
        //if (fabs(b-a)*0.5 < delta || fabs(f(c)) < epsn) return c;
        if ((fabs(b-a) < delta)) return c;
        (f(a)*f(c) < 0) ? b = c : a = c;
        return bisctn0(a, b, f, delta, epsn);
    }

    double fa(double x) { // test function (a)
        if(x) return 1.0/x - pow(2,x);
        else {
            std::cout << "division by zero occurred in function fa().\n" ;
            exit(1);
        }
    }

    double fb(double x) { // test function (b)
        return pow(2,-x) + exp(x) + 2*cos(x) - 6;
    }

    double fc(double x) { // test function (c)
        double denorm = ((2*x-9)*x +18)*x -2; // nested multiply
        if(denorm) return (((x+4)*x+ 3)*x + 5) / denorm;
        else {
            std::cout << "division by zero occurred in function f(c).";
            exit(1);
        }
    }
    
    double bisctn1(double a, double b, double (*f)(double), double u, double delta, double epsn) {
        double e = (b - a)*0.5; // shrink interval size
        double c = a + e;       // middle point
        double w = f(c);        // f(c) value at middle point
        if (fabs(e) < delta || fabs(w) < epsn) return c;
        
        ((u>0 && w<0) || (u<0 && w>0)) ? (b = c):(a = c, u = w) ;
        return bisctn1(a, b, f, u, delta, epsn);
    }
    
    double bisctn2(double a, double b, double (*f)(double), double u, double delta, double epsn, int maxit) {
        static int itern = 1;
        double e = (b - a)*0.5; // shrink interval size
        double c = a + e;       // middle point
        double w = f(c);        // f(c) value at middle point
        if (fabs(e) < delta || fabs(w) < epsn || itern++ > maxit) return c;
        
        ((u>0 && w<0) || (u<0 && w>0)) ? (b = c):(a = c, u = w) ;
        return bisctn2(a, b, f, u, delta, epsn, maxit);
    }
    
    double bisctn3(double a, double b, double (*f)(double), double u, double delta, double epsn, int maxit, int& itern) {
        double e = (b - a)*0.5; // shrink interval size
        double c = a + e;       // middle point
        double w = f(c);        // f(c) value at middle point
        if (fabs(e) < delta || fabs(w) < epsn || itern++ > maxit) return c;
        
        ((u>0 && w<0) || (u<0 && w>0)) ? (b = c):(a = c, u = w);
        return bisctn3(a, b, f, u, delta, epsn, maxit, itern);
    }
}
