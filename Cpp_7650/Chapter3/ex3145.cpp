//
//  ex3143.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

//#include <iostream>
//#include <math.h>
//
//double sequence(unsigned);
//double sequence2(unsigned);
//
//int main(int argc, const char * argv[]){
//
//    std::cout << "Please supply any integer number = ";
//    
//    unsigned input;
//    std::cin >> input;
//    
//    //std::cout.width(32);
//    std::cout.precision(32);
//    std::cout << std::endl << " Sequence 1 = " << sequence(input) << '\n';
//    
//    //std::cout.width(32);
//    std::cout.precision(32);
//    std::cout << " Sequence 2 = " << sequence2(input) << std::endl << std::endl;
//
//    return 0;
//}
//
//
//double sequence(unsigned n){
//    double result = 0.;
//    
//    for(unsigned i = 1; i <= n; i++)
//        result += sqrt(n) - sqrt(n - 1);
//    
//    return result;
//}
//
//
//double sequence2(unsigned n){
//    double result = 0.;
//    
//    for(unsigned i = 1; i <= n; i++)
//        result += 1./(sqrt(n) + sqrt(n - 1));
//    
//    return result;
//}
