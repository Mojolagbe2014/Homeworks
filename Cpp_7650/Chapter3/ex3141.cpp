//
//  ex3141.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

//#include <stdio.h>
//#include <iostream>
//#include <stdlib.h>
//
//int main(int argc, const char * argv[]){
//    int lowerBound = 1;
//    int upperBound = 50;
//    
//    const unsigned int n = 5;
//    int randArray[n];
//    
//    int sum = 0, min = upperBound, max = 0;
//    
//    srand(time(0));         // refresh the random number generator
//    
//    for(unsigned i = 0; i < n; i++){
//        //int randNum = rand();
//        int randNum = lowerBound + int((double(rand()) / double(RAND_MAX))*(upperBound - lowerBound+1));
//        
//        sum += randNum;
//        randArray[i] = randNum;
//        
//        min = randNum > min ? min : randNum;
//        max = randNum > max ? randNum : max;
//        
//        std::cout << randNum << std::endl;
//    }
//    
//    std::cout << "Average = " << double(sum)/n << std::endl;
//    std::cout << "Min Val = " << min << std::endl;
//    std::cout << "Max Val = " << max << std::endl;
//
//    return 0;
//}
