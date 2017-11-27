//
//  test.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-11-17.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <stdio.h>
#include <vector>
#include <iostream>

//#define RUN_SECTION
#ifdef RUN_SECTION
class Pt {
private:
    double x;
public:
    Pt(double a = 0) { x = a; };
     //void draw() const { std::cout << x; }
};


class Pt2d : public Pt {
private:
    double y;
public:
    Pt2d(double a = 0, double b = 0) : Pt(a), y(b) {  }
    virtual void draw() const {
        //Pt::draw();
        std::cout << "x " << y;
    }
};


class Pt3d : public Pt2d {
private:
    double z;
public:
    Pt3d(double a = 0, double b = 0, double c = 0) : Pt2d(a, b) { z = c; };
    void draw() const {
        Pt2d::draw();
        std::cout << " " << z;
    }
};

void h(const std::vector<Pt2d*> v) {
    for (int i =0; i < v.size(); i++) {
        v[i]->draw();
        std::cout << '\n';
    }
}



int main(){
    Pt a(5);
    Pt2d b(4, 9);
    Pt3d c(1, 2, 3);
    
    std::vector<Pt2d*> v(2);
    //v[0] = &a;
    v[0] = &b;
    v[1] = &c;
    h(v);

    
    return 0;
}
#endif
