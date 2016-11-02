cl = 0.05;

Point(1) = {-1, -1, 0, cl};
Point(2) = {1, -1, 0, cl};
Point(3) = {-1, 1, 0, cl};
Point(4) = {1, 1, 0, cl};
Point(6) = {0.4, 0, 0, cl};
Point(7) = {-0.4, 0, 0, cl};
Point(8) = {0, 0.4, 0, cl};
Point(9) = {0, -0.4, 0, cl};
Point(10) = {0, 0, 0};

Line(1) = {2, 4};
Line(2) = {4, 3};
Line(3) = {3, 1};
Line(4) = {1, 2};

Circle(5) = {9, 10, 6};
Circle(6) = {6, 10, 8};
Circle(7) = {8, 10, 7};
Circle(8) = {7, 10, 9};
Line Loop(9) = {1, 2, 3, 4};
Line Loop(10) = {6, 7, 8, 5};

Plane Surface(11) = {9, 10};
Plane Surface(12) = {10};

Physical Line(100) = {1, 2, 3, 4};
Physical Surface(201) = {12};
Physical Surface(200) = {11};
