function [ X , m , n , flag , x1 , y1 , eps ] = object4( a , b , l )
%--------------------------------------------------------------------------
%  Generates sets of points for inhomogenious plane dielectric slab, center
%  at x=0, y=0. Epsilon varios from 4 in the center to 1 at the edge along
%  axis y
%  a - half thickness , m
%  b - half width , m
%  l - cell size, m
%  m , n - size of the grid
%  eps - epsilon inside the object assigned for each cell
%--------------------------------------------------------------------------

xmin = -1.2*b;
ymin = -1.2*b;

xmax = 1.2*b;
ymax = 1.2*b;

n = ceil( ( xmax - xmin ) / l );
m = ceil( ( ymax - ymin ) / l );

X = zeros( m*n , 4 );
eps = zeros( m*n , 1 );

flag = zeros( m , n );
x1 = flag; y1 = flag;

ii = 1;
for j = 1 : n   %raw - x
  xi = xmin + 0.5*l + l*(j-1);   %coordinates of the center of the cell
for i = 1 : m   %line - y
   yi = ymax - 0.5*l - l*(i-1);
   x1(i,j) = xi;
   y1(i,j) = yi;
   if ( ( abs(xi) <= a ) && ( abs(yi) <= b ) ) %condition for the slab
      X( ii , 1 ) = xi;
      X( ii , 2 ) = yi;
      X( ii , 3 ) = j;
      X( ii , 4 ) = i;
      
      eps( ii ) = -(3./b) * abs(yi) + 4.; %linear dependence for epsilon
      flag(i,j) = 1;  %flag of the object
      ii = ii + 1;
   end
end
end
X = X(1:ii-1,:);
eps = eps(1:ii-1);
