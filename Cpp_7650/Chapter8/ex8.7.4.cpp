//  ex8.7.4.cpp
//  Cpp4Engineers
//#define RUN_SECTION
#ifdef RUN_SECTION

#include <iostream>

using namespace std;

class B {
    double* d;
    unsigned n;

public :
    B(unsigned n = 0) : n(n){ d = new double [n]; cout << n << " doubles allocated\n"; }
    virtual ~B() { delete[] d; cout << n << " doubles deleted\n"; }
};

class D: public B {
    int* i;
    unsigned n;
public:
    D(unsigned ni = 0, unsigned nd = 0) : B(ni), n(nd) {
        i = new int[n];
        cout << n << " ints allocated\n";
    }
    
    ~D() { delete[] i; cout << n << " ints deleted\n";  }
};

int main() {
    B* p = new D(20, 1000); // 'new ' constructs a D object
    delete p; // 'delete' frees a B object since p is a pointer to B
}

#endif
