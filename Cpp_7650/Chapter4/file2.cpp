//
//  file2.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-04.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <stdio.h>
#include <iostream>
//#define RUN_SECTION
#ifdef RUN_SECTION
extern double x;         // another file may define x
extern double f(double); // another file may define f
void g(double z) { x = f(z); }


int main (){
    
    
    return 0;
}
#endif

