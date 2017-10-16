//
//  StringExample.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-09.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <fstream>
#include <stdio.h>
//#define RUN_SECTION

#ifdef RUN_SECTION
int main(int argc, const char * argv[]) {
    
    std::ifstream infile("data/item1.txt", std::ios_base::in) ; // open file to read
    int i;
    double d;
    infile >> i; // read from "item1.txt"
    infile >> d;
    char result [20] ; // output file name
    sprintf(result, "data/%s%d%s%d%s.txt", "ex",i,"-", int(1/d), "h");
    
    std::ofstream outfile(result,std::ios_base::out); // open output file
    outfile << "example number: " << i << '\n';
    outfile << "grid size: " << d << '\n';
    
    infile.close();  // close input file stream
    outfile.close(); // close output file stream
    
    return 0;
}
#endif
