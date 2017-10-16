//
//  StringExample.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-09.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <fstream>
#include <string>
#include <stdlib.h>
#include <iostream>
//#define RUN_SECTION

#ifdef RUN_SECTION
int main(int argc, const char * argv[]) {
    std::string source = "data/item4.txt", result = "data/result.txt";
    std::ifstream infile(source, std::ios_base::in) ; // open for read
    if (!infile)
        std::cout << "can not open file: " << source << " for read\n";
    
    std::string s; int i; double d;
    
    infile.ignore(std::numeric_limits<int>::max(), '\n'); // ignore the first line
    
    getline(infile, s, '/'); // get a line terminated by '/'
    i = atoi(s.c_str());     // convert to an int
    infile.ignore(80, '\n'); // ignore the rest of line, comments
    
    getline(infile, s, '/'); // get a line terminated by '/'
    d = atof(s.c_str());     // convert to a float
    
    std::ofstream outfile(result, std::ios_base::out);
    if (!outfile)
        std::cout << "can not open file: " << result << " for write\n";
    
    outfile.setf(std::ios_base::scientific, std::ios_base::floatfield);
    outfile << "example number: " << i << '\n';
    outfile << "grid size: " << d << '\n';
    
    infile.close();  // close input file stream
    outfile.close(); // close output file stream
    
    return 0;
}
#endif
