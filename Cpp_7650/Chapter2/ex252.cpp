//
//  ex252.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-20.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

//#include <iostream>
//#include <stdlib.h>
//
//int main(int argc, const char * argv[]){
//    
//    int lowerBound = 5;
//    int upperBound = 50;
//    unsigned iter = 100;
//
//
//    std::cout << "=== A Program that Prints RAND_MAX and Generate Random Nos Between 5 & 50 ===" << "\n\n";
//    
//    std::cout << "RAND_MAX = " << RAND_MAX << std::endl << std::endl;
//    
//    
//    for(unsigned i = 0; i < iter; ++i){
//        int randNum = lowerBound + int((double(rand()) / double(RAND_MAX))*(upperBound - lowerBound+1));
//        std::cout << randNum << std::endl;
//        
//        if(randNum > upperBound || randNum < lowerBound){
//            std::cout << "Error occurred! Out of range. Random Number = " << randNum << std::endl;
//            break;
//        }
//    }
//
//
//    return 0;
//}
