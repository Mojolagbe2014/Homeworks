function E = incident_wave1( wave_kind, N , k0 , phi0 , ro0 , x , y )
%--------------------------------------------------------------------------
% Provides plane incident wave values in points x and y
% wave_kind = 'plane' or 'cylindrical'
% N - number of cells
% k0 - wave number, 1/m
% phi0 - angle of incident wave, degrees counts from axis x counterclockwise
% (phi0, ro0) - coordinate of the point source for the cylindrical wave
% x(1..N), y(1..N) - coordinates of points x , y
% E(1..N, 1..N) - output electric field in these points
%--------------------------------------------------------------------------

sphi = sin( phi0 * pi / 180 );
cphi = cos( phi0 * pi / 180 );
zi = sqrt(-1);

E = zeros( N , 1 );

if ( strcmp(wave_kind,'plane') == 1 ) 
  E = exp( -k0 * zi .* ( x * cphi + y * sphi ) );
else
if ( strcmp(wave_kind,'cylindrical') == 1 )  
  % location of the point source (current along axis z)
  x0 = ro0 * cphi;
  y0 = ro0 * sphi;
  
%  I = 1; %we assume the unit source
%  c = 3e+8;
%  omega = k0 * c;
%  nu0 = 4*pi*1e-7; %vacuum permeability

  k0ro = k0*sqrt( (x-x0).^2 + (y-y0).^2 );
  H0 = besselh( 0 , 1 , k0ro );
  G = H0 * zi/4; %Green's function (cylindrical wave)

%  E = zi * omega * nu0 * I * G;
  E = H0;
else
  disp('ERROR: wrong kind of incident wave... ')
end
end
