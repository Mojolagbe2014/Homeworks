//
//  Point.hpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-02-10.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//

#ifndef Point_h
#define Point_h

#include <stdio.h>
#include <iostream>

class Point {
    double x;
    
public:
    Point(double x = 0) : x(x) {};
    Point(const Point& p) { x = p.x;}
    Point& operator=(const Point& p) {
        if (this != &p) x = p.x;
        return *this;
    }
    
    void draw() const { std::cout <<  x; }
};

#endif /* Point_h */
