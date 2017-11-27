//
//  test.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-18.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>
#include <stdlib.h>
//#define RUN_SECTION

#ifdef RUN_SECTION
int main(int argc, const char * argv[]){
    
    enum vals {ab = -90, yb = 1000};
    
    vals x, y;
    
    x = vals(-2000);
    
    std::cout << x << std::endl;
    
//    int i = 5;
//    int j;
//    
//    j = (i--) + (++i);
//    
//    std::cout << "result = " << j << std::endl;

    return 0;
}
#endif
