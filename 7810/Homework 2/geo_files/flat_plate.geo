cl = 0.02;

Point(1) = {0, 0, 0, cl};
Point(2) = {1, 0, 0, cl};
Point(3) = {0, 1, 0, cl};
Point(4) = {1, 1, 0, cl};
Line(1) = {2, 4};
Line(2) = {4, 3};
Line(3) = {3, 1};
Line(4) = {1, 2};

Line Loop(9) = {1, 2, 3, 4};
Line Loop(10) = {6, 7, 8, 5};

Plane Surface(11) = {9, 10};
Plane Surface(12) = {10};

Physical Line(101) = {1};
Physical Line(102) = {2};
Physical Line(103) = {3};
Physical Line(104) = {4};
Physical Surface(201) = {12};
Physical Surface(200) = {11};
