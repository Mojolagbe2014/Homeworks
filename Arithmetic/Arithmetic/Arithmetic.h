//
//  Arithmetic.h
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-07.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#ifndef Arithmetic_h
#define Arithmetic_h

#include <stdio.h>
#include <iostream>

namespace Arithmetic {
    class SimpleArithmetic{
    public:
        static double sum(double, double);
        
        static double product(double, double);
        
        static double subtract(double, double);
        
        double divide(double, double);
    };
};

#endif /* Arithmetic_h */
