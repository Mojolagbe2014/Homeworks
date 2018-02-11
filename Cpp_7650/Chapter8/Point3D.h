//
//  Point3D.hpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-02-11.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//

#ifndef Point3D_h
#define Point3D_h

#include <stdio.h>
#include <iostream>
#include "Point2D.h"

class Point3D : Point2D {
    double z;
    
public:
    Point3D(double x = 0, double y = 0, double z = 0) : Point2D(x, y), z(z) {}
    void draw() const {
        Point2D::draw();            // draw x and y
        std::cout << " " << z;           // draw z
    }
};

#endif /* Point3D_h */

