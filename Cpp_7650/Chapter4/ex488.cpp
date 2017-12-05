//
//  main.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-04.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <fstream>
#include <stdio.h>
#include <iostream>
//#define RUN_SECTION

#ifdef RUN_SECTION
void output(int i){
    char filename [30] ; // output file name
    sprintf(filename, "data/%s%d.txt", "ex",488);
    
    std::ofstream outfile(filename,std::ios_base::out); // open output file
    
    outfile.setf(std::ios_base::showbase);  // show base of output
    std::cout.setf(std::ios_base::showbase);
    outfile << i << '\n'; // decimal, default
    std::cout << i << std::endl;
    
    outfile.setf(std::ios_base::oct, std::ios_base::basefield);
    std::cout.setf(std::ios_base::oct, std::ios_base::basefield);
    outfile << i << '\n'; //octal, base 8
    std::cout << i << std::endl;
    
    outfile.setf(std::ios_base::hex , std::ios_base::basefield);
    std::cout.setf(std::ios_base::hex, std::ios_base::basefield);
    outfile << i << '\n'; // hex, base 16
    std::cout << i << std::endl;
    
    outfile.setf(0, std::ios_base::basefield); // reset to default
    outfile << std::bitset<32>(i) << '\n'; //bin, base 2
    std::cout << std::bitset<32>(i) << std::endl;
    
    outfile.close(); // close output file stream
}


int main(int argc, const char * argv[]) {
    int n;
    std::cout << "Enter an integer: ";
    std::cin >> n;
    
    output(n);
    
    return 0;
}
#endif
