cl = 0.05;
Point(6) = {0.4, 0, 0, cl};
Point(7) = {-0.4, 0, 0, cl};
Point(8) = {0, 0.4, 0, cl};
Point(9) = {0, -0.4, 0, cl};
Point(10) = {0, 0, 0};

Circle(5) = {9, 10, 6};
Circle(6) = {6, 10, 8};
Circle(7) = {8, 10, 7};
Circle(8) = {7, 10, 9};
Line Loop(9) = {1, 2, 3, 4};
Line Loop(10) = {6, 7, 8, 5};

Plane Surface(11) = {9, 10};
Plane Surface(12) = {10};

Physical Line(100) = {1, 2, 3, 4};
Physical Line(101) = {5};
Physical Line(102) = {6};
Physical Line(103) = {7};
Physical Line(104) = {8};
Physical Surface(201) = {12};
Physical Surface(200) = {11};
