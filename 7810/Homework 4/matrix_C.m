function C = matrix_C( N , k0 , a , x , y , eps )
%--------------------------------------------------------------------------
% Calculates matrix Cmn
% N - total number of cells
% N x N - size of the matrix
% k0 - wave number in vacuum, 1/m
% a  - size of the circle around each cell, m
% x(N), y(N) - array of points (centers of each cell)
% eps - Complex dielectric constant of the object - assume that epsilon is
% changing inside the object!!!
%--------------------------------------------------------------------------

zi = sqrt(-1);

% for the case m = n
ka = k0 * a;
H1 = besselh( 1 , 1 , ka );
%c0 = 1 - zi*( pi * ka * H1 + 2*zi ) * ( eps - 1 ) / 2.;
c0 = (1 - zi*( pi * ka * H1 + 2*zi ) * ( eps - 1 ) / 2.) ./ (eps-1);

J1 = besselj( 1 , ka );

%c1 = -zi * pi * ka * J1 * ( eps - 1 ) / 2.;
c1 = -zi * pi * ka * J1 / 2.;

ee = eye( N , N );

C = repmat( c0./2 , 1 , N ); %all diagnal elements are c0, all the others are 0
C = C.*ee;

% create triangular matrix
%for j = 1 : N
%for i = 1 : j-1
%   k0ro = k0*sqrt( ( x(i) - x(j) )^2 + ( y(i) - y(j) )^2 ); %distance between points i and j
%   H0 = besselh( 0 , 1 , k0ro );
%   C( i , j ) = c1 * H0;
%end 
%end

e = repmat( transpose(eps-1) , N , 1 ); % repeat of the array: [eps1 eps2 ... epsN] N times

% create triangular matrix
for j = 2 : N
 	x1 = x( 1 : j - 1 );   
 	y1 = y( 1 : j - 1 );    
 	k0ro = k0*sqrt( ( x1 - x(j) ).^2 + ( y1 - y(j) ).^2 ); %distance between points i and j
 	H0 = besselh( 0 , 1 , k0ro );
 	C( 1 : j - 1 , j ) = c1 * H0;
end

% the full matrix is symmetric
C = C + transpose(C);

C = C.*e;
