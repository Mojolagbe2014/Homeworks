function [ X , m , n , flag , x1 , y1 ] = object5( a , b , d , l )
%--------------------------------------------------------------------------
%  Generates sets of points for the homogenious dielectric square, center at x=0, y=0
%  a - half thickness , m
%  b - half width , m
%  l - cell size, m
%  [-d:d,-d:d] - area around the square
%  m , n - size of the grid
%--------------------------------------------------------------------------

xmin = -d;
ymin = -d;

xmax = d;
ymax = d;

n = ceil( ( xmax - xmin ) / l );
m = ceil( ( ymax - ymin ) / l );

X = zeros( m*n , 4 );

flag = zeros( m , n );
x1 = flag; y1 = flag;

ii = 1;
for j = 1 : n   %raw - x
  xi = xmin + 0.5*l + l*(j-1);   %coordinates of the center of the cell
for i = 1 : m   %line - y
   yi = ymax - 0.5*l - l*(i-1);
   x1(i,j) = xi;
   y1(i,j) = yi;
   if ( ( abs(xi) <= a ) && ( abs(yi) <= b ) ) %condition for the square cylinder
      X( ii , 1 ) = xi;
      X( ii , 2 ) = yi;
      X( ii , 3 ) = j;
      X( ii , 4 ) = i;
      flag(i,j) = 1;  %flag of the object
      ii = ii + 1;
   end
end
end
X = X(1:ii-1,:);