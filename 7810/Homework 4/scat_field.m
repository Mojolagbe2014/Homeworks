function E1 = scat_field( x , y , E , k0 , c0 , x1 , y1 , eps )
%--------------------------------------------------------------------------
% It calculated scattered field at point (x1,y1) which is outside the
% cylinder
% x (1..N) , y (1..N) - coordinates of the cells inside the cilinder
% E(1..N) - field inside the cylinder
% k0 - wave number, 1/m
% c0 = -zi * pi * ka * (eps-1) * J1;
% a - radius of circle in each cell
% eps - CDC of the object - varies within the body
% x1. y1 - coordinates of the point outside the object where the scattered
% field is found
%--------------------------------------------------------------------------

kro = k0 * sqrt( ( x1 - x ).^2 + ( y1 - y ).^2 );
H = besselh( 0 , 1 , kro );
s = sum( (E .* H).*(eps-1) );   % sum of the series

E1 = c0 * s;
