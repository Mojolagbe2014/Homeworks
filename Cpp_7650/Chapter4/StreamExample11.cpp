//
//  StringExample.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-09.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <fstream>
#include <sstream>
#include <string>
#define RUN_SECTION

#ifdef RUN_SECTION
int main(int argc, const char * argv[]) {
    
    std::ifstream infile("data/item1.txt", std::ios_base::in) ;
    int i; double d;
    
    infile >> i >> d; // read from input file
    
    std::ostringstream tmp; // declare variable tmp
    tmp << "data/" << "ex" << i << "-" << int(1/d) << "h" << ".txt";
    std::string ofname = tmp.str(); // convert it into string
    
    std::ofstream outfile(ofname.c_str(),std::ios_base::out);
    outfile << "example number: " << i << '\n';
    outfile << "grid size: " << d << '\n';
    
    infile.close();  // close input file stream
    outfile.close(); // close output file stream
    
    return 0;
}
#endif
