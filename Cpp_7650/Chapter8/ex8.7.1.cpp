//  ex8.7.cpp
//  Cpp4Engineers
//#define RUN_SECTION
#ifdef RUN_SECTION

#include <stdio.h>
#include <iostream>

class Point {
    double x;
public:
    Point(double x = 0.) : x(x) {};
    Point(const Point& p) { x = p.x;}
    Point& operator=(const Point& p) {
        if (this != &p) x = p.x;
        return *this;
    }
    
    void draw() const { std::cout <<  x; }
    const double& X() const { return x; }
};

class Point2D : public Point {
    double y;
public:
    Point2D(double x = 0., double y = 0.) : Point(x), y(y) {}
    void draw() const {
        Point::draw();
        std::cout << ", " << y;
    }
    
    const double& Y() const {return y; }
};

class Point3D : Point2D {
    double z;
public:
    Point3D(double x = 0., double y = 0., double z = 0.) : Point2D(x, y), z(z) {}
    void draw() const {
        Point2D::draw();            // draw x and y
        std::cout << ", " << z;           // draw z
    }
};

void getEqnOfLine(const Point2D& p1, const Point2D& p2){
    const double& y1 = p1.Y();
    const double& x1 = p1.X();
    const double& y2 = p2.Y();
    const double& x2 = p2.X();
    double m = (y2 - y1) / (x2 - x1);
    double b = y1 - m*x1;
    
    std::cout << "\nEquation of line at Points (";
    p1.draw(); std::cout << ") and ("; p2.draw();
    std::cout << ")\ny = " << m << "x" << (b>0 ? '+' : '-') << (b>0 ? b : -b) << std::endl;
}

int main(){
    Point2D p1(-3, 3);
    Point2D p2(3, -1);
    getEqnOfLine(p1, p2);

    return 0;
}

#endif
