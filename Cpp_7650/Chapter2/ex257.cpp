//
//  ex257.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-20.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>
//#define RUN_SECTION

#ifdef RUN_SECTION
int main(int argc, const char * argv[]){
    
    int i = 5, j, k;
    
    j = (i = 7) + (k = i +3);
    
    std::cout << "j = " << j << std::endl;
    
    return 0;
}
#endif
