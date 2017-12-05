//
//  ex3144.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>
//#define RUN_SECTION

#ifdef RUN_SECTION

unsigned getDecimalDigits(int);

int main(int argc, const char * argv[]){

    std::cout << "Please supply any integer number = ";
    
    int input;
    std::cin >> input;
    std::cout << std::endl << "Number of digits in " << input << " is " << getDecimalDigits(input) << std::endl << std::endl;

    return 0;
}


unsigned getDecimalDigits(int input){
    int temp;
    unsigned iter = 0;
    
    temp = input >= 0 ? input  : input * -1;
    
    while(temp > 0){
        temp /= 10;
        ++iter;
    }
    
    return iter;
}
#endif
