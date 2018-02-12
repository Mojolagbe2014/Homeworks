//#define RUN_SECTION
#ifdef RUN_SECTION

#include <iostream>
using namespace std;

class A {
    double* pd;
public :
    A() { pd = new double [20]; cout << "20 doubles allocated\n" ; }
    ~A() { delete [] pd; cout << "20 doubles deleted\n"; }
};

class B: public A {
    int* pi;
public:
    B() : A() { pi = new int[1000]; cout << "1000 ints allocated\n";  }
    ~B() { delete[] pi; cout << "1000 ints deleted\n"; }
};

int main() {
    //B* p = new B(); // 'new ' constructs a B object using B pointer
    A* p = new B();  // 'new ' constructs a B object using A pointer (base class)
    delete p; // 'delete'
}
#endif
