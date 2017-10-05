//
//  NamespaceAlias.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-30.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>
#include <string>
//#define RUN_SECTION


namespace Numerical_Integration { // name is very long
    double lowerbound;
    double (*integrand) (double);
    // . . .
}


namespace Animal {
    namespace Mammal {
        namespace HumanBeing{
            std::string scientificName(){ return "Homo Sapien"; }
        }
    }
}

namespace Man = Animal::Mammal::HumanBeing;
namespace NI = Numerical_Integration;


#ifdef RUN_SECTION
int main (int argc, char** argv){
    NI::lowerbound = 1.0;
    std::cout << std::endl << Man::scientificName() << std::endl;
    
    return 0;
}
#endif
