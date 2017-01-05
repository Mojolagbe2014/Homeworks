function sigma0 = nrcs( phi , E , x , y , k0 , a , eps )
%--------------------------------------------------------------------------
% Calculates NRCS
% phi - angle of observation
%--------------------------------------------------------------------------

sphi = sin( phi * pi / 180 );
cphi = cos( phi * pi / 180 );

zi = sqrt(-1);

ka = k0 * a;

J1 = besselj( 1 , ka );

%sigma0 = pi*pi * k0 * (abs( (eps-1) * a * J1 )^2);
sigma0 = pi*pi * k0 * (abs( a * J1 )^2);

s = sum( E.*exp( -zi*k0*( x*cphi + y*sphi ) ).*(eps-1) ); % sum of the series

sigma0 = sigma0 * (abs(s)^2);




