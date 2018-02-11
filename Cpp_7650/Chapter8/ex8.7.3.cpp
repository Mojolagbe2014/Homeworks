//
//  Point2D.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-02-10.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//
//#define RUN_SECTION
#ifdef RUN_SECTION

#include <iostream>

using namespace std;

class A {
    double* pd;
public :
    A() {
        pd = new double [20];
        cout << "20 doubles allocated\n" ; }
    ~A() {
        delete [] pd;
        cout << "20 doubles deleted\n";
    }
};

class B: public A {
    int* pi;
    
public:
    B() : A() {
        pi = new int[1000];
        cout << "1000 ints allocated\n";
    }
    
    ~B() {
        delete[] pi;
        cout << "1000 ints deleted\n";
    }
};

int main() {
    //B* p = new B(); // 'new ' constructs a B object using B pointer
    A* p = new B();  // 'new ' constructs a B object using A pointer (base class)
    delete p; // 'delete'
}

/* A virtual destructor is a virtual function defined in the base class of a derived class. A virtual destructor is used such that proper cleanup in the allocated memory is achieved. Such use is required when an object or a class of the derived class is manipulated through the base class's pointer and both the superclass and sub-class have dynamic memory allocations; This implies that there is run-time polymorphism. However, there is no need of virtual destructor if and only if the derived class is not manipulated through the base class's pointer; In this case memory allocation will be properly deallocated.
 
 Concisely, a class with run-time polymorphism (virtual functions) needs to have virtual destructor.
 
 Example: Consider a derived class B having a base class A such that memory is allocated in both A and B. Expression like:
 A* obj = new B();  // manipulation of derived class through the base class
 delete obj;
 To achieve the desired memory deallocation, the destructor in base class A should be made virtual and as such proper cleanups can be achieved in B.
 */

#endif
