function C = matrix_C1( N , k0 , a , x , y , eps )
%--------------------------------------------------------------------------
% Calculates matrix Cmn
% N - total number of cells
% N x N - size of the matrix
% k0 - wave number in vacuum, 1/m
% a  - radius of the circle in the cell, m
% x(N), y(N) - array of points (centers of each cell)
% eps - Complex dielectric constant of the object - assume that epsilon is
% changing inside the object!!!
%--------------------------------------------------------------------------

zi = sqrt(-1);
ka = k0 * a;

% calculation Imn
%--------------------------------------------------------------------------
H1 = besselh( 1 , 1 , ka );
c0 = - zi*( pi * ka * H1 + 2*zi )/ 2.;

J1 = besselj( 1 , ka );
c1 = -zi * pi * ka * J1 / 2.;

I = eye( N , N ) .* ( zeros(N,N)+c0/2 ); %all diagnal elements are c0, all the others are 0

% create triangular matrix
for j = 2 : N
 x1 = x( 1 : j - 1 );   
 y1 = y( 1 : j - 1 );    
 k0ro = k0*sqrt( ( x1 - x(j) ).^2 + ( y1 - y(j) ).^2 ); %distance between points i and j
 H0 = besselh( 0 , 1 , k0ro );
 I( 1 : j - 1 , j ) = c1 * H0;
end

% the full matrix is simmetric
I = I + transpose(I);
%--------------------------------------------------------------------------


delta = eye( N , N );
e = repmat( transpose(eps-1) , N , 1 ); % repeat of the array: [eps1 eps2 ... epsN] N times

C = delta + I.*e;

