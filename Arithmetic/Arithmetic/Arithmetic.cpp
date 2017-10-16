//
//  Arithmetic.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-07.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include "Arithmetic.h"


namespace Arithmetic {
    double SimpleArithmetic::sum(double a, double b) { return (a+b); }
    
    double SimpleArithmetic::product(double a, double b) { return (a*b); }
    
    double SimpleArithmetic::subtract(double a, double b) { return (a > b ? a - b : b - a); }
    
    double SimpleArithmetic::divide(double a, double b) { return (a/b); }
}
