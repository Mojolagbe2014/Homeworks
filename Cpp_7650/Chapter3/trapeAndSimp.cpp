//
//  trapezAndSimp.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//
//
#include <stdio.h>
#include <iostream>
#include <math.h>
//#define RUN_SECTION

typedef double (*pfn)(double); //define pfn for integrand
double trapezoidal(double a, double b, pfn f, int n);
double simpson(double a, double b, pfn f, int n);


double square(double d){ return d*d; }


#ifdef RUN_SECTION
int main(int argc, const char * argv[]){
    unsigned numPoints = 100;
    
    double result = trapezoidal(0, 5, square, numPoints);
    std::cout << "Integral using trapezoidal with n = 100 is: " << result << '\n';
    
    result = simpson(0, 5, square, numPoints);
    std::cout << "Integral using simpson with n = " << numPoints << " is: " << result << '\n';
    
    
    result = trapezoidal(0, 5, sqrt, numPoints);
    std::cout << "Integral using trapezoidal with n = " << numPoints << " is: " << result << '\n';
    
    result = simpson(0, 5, sqrt, numPoints);
    std::cout << "Integral using simpson with n = " << numPoints << " is: " << result << '\n';
    
    
    return 0;
}
#endif


double trapezoidal(double a, double b, pfn f, int n){
    double h = (b - a)/n;       // size of each sub interval
    double sum = f(a)*0.5;
    
    for(int i = 1; i < n; i++) sum += f(a + i*h);
    sum += f(b)*0.5;
    
    return sum*h;
}

double simpson(double a, double b, pfn f, int n){
    double h = (b - a)/n;
    double sum = f(a)*0.5;
    
    for(int i; i < n; i++)  sum += f(a + i*h);
    sum += f(b) * 0.5;
    
    double summid = 0.;
    for(int i = 1; i <= n; i++) summid += f(a + (i - 0.5)*h);
    
    return (sum + 2*summid)*h/3.;
}
