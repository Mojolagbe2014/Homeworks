//
//  Point2D.hpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-02-10.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//

#ifndef Point2D_h
#define Point2D_h

#include <stdio.h>
#include <iostream>
#include "Point.h"

class Point2D : public Point {
    double y;
    
public:
    Point2D(double x = 0, double y = 0.) : Point(x), y(y) {}
    void draw() const {
        Point::draw();
        std::cout << " " << y;
    }
};

#endif /* Point2D_h */
