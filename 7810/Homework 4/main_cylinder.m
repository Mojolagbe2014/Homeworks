clc; clear;
tic

% constants:
c = 3e+8;      %speed of light, m/s
%eps0 = 8.85418781762e-12; %permittivity of vacuum, F/m
zi = sqrt(-1);

f = 0.3e+9;      %frequency, Hz
phi0 = 135;      %angle of incident wave, degrees counts from axis x counterclockwise
tan_delta = 0.;
eps1 = 4.;

Lam = c / f;   %wavelength, m
k0 = 2*pi/Lam; %wave number

%sigma = eps1*tan_delta*(2*pi*f*eps0);

eps = eps1*(1 + zi * tan_delta);

wave_kind = 'plane';
%wave_kind = 'cylindrical';

ro0 = 0.5*Lam; % position of the point source for incident cylindrical wave only

% parameters for (semi)cylindrical shell
% ra = 0.25*Lam;
% rb = 0.3*Lam;
% d = rb;

% parameters for slab
%ra = 0.05*Lam/2;
%rb = 2.5*Lam/2;
%d = rb;

% parameters for square cylinder
ra = Lam/2;
rb = Lam/2;
d = 3*Lam/2;

% Cell Size
% l = 0.01*Lam/real(sqrt(eps));        %for (semi)cylindrical shell
%l = 0.02*Lam/real(sqrt(eps));        %for thin slab nomogeneous/inhomogeneous
l = 0.03*Lam/sqrt(eps1);                 %for square


% [ X , m , n , flag , xx , yy ] = object1( ra , rb , l );         % cylindrical shell
% [ X , m , n , flag , xx , yy ] = object2( ra , rb , l );         % semicylindrical shell
% [ X , m , n , flag , xx , yy ] = object3( ra , rb , l );         % homogeneous thin slab
%[ X , m , n , flag , xx , yy , eps ] = object4( ra , rb , l );   % inhomogeneous thin slab: eps(y) = 4 - (3/b) * abs(y)
[ X , m , n , flag , xx , yy ] = object5( ra , rb , d , l );      % cylindrical square

a = l / sqrt(pi);  %radius of the circle for each cell

disp('Number of cells in the object: ')
N = size(X,1)

% dielectrics of the object is a constant:
eps = zeros(N,1) + eps;

% x coordinate is stored in the first column of X
% y coordinate is stored in the second column of X
x = X(:,1);
y = X(:,2);

disp('Image size: ');
m
n

disp('Calculation of matrix coefficients Cmn...')
C = matrix_C1( N , k0 , a , x , y , eps );

%total field inside the object
disp('Calculation of the field inside the object...')
Ei = incident_wave1( wave_kind , N , k0 , phi0 , ro0 , x , y );
E = C \ Ei;

% calculation of the incident field distribution
disp('Calculation of the incident field...')
Ei_dist = zeros( m , n ); 
for j = 1 : n
for i = 1 : m
  x1 = xx(i,j);  %coordinates of the center of the cell
  y1 = yy(i,j);
  Ei_dist(i,j) = incident_wave1( wave_kind , 1 , k0 , phi0 , ro0 , x1 , y1 );
end
end

% calculation of the scattered field
disp('Calculation of the scattered field...')

% precalculation of the constant
ka = k0*a;
J1 = besselj( 1 , ka );
c0 = zi * pi * ka * J1/2;

E_tot = zeros( m , n ); %total field distribution
eps_object = zeros(m,n);
for j = 1 : n
for i = 1 : m
   fl = flag(i,j); 
   if ( fl == 0 ) %if point is outside the cylinder
    x1 = xx(i,j);  %coordinates of the center of the cell
    y1 = yy(i,j);
    E_tot(i,j) = scat_field( x , y , E , k0 , c0 , x1 , y1 , eps ) + Ei_dist(i,j); %total field outside the object (scat+incident)
   else  %inside the dielectric
     ii=find( (X(:,3)==j) & (X(:,4)==i) );
     E_tot(i,j) = E(ii);
     eps_object(i,j) = eps(ii);
   end
   
end
end

aE_tot = abs(E_tot);

toc

phi = 0.;
r = (ra+rb) / 2;  % in the center of the shell
for k = 1 : 361
 x1 = r * cos( phi * pi / 180 );
 y1 = r * sin( phi * pi / 180 );                                                                                                                                                                                                                     ( phi * pi / 180 );
% j = round( 1 + ( x1 - xx(1,1) ) / l );
% i = round( 1 - ( y1 - yy(1,1) ) / l );
% val = aE_tot(i,j);
 val = interp2( xx , yy , aE_tot , x1 , y1 , 'linear' ); % bilinear interpolation
 Ec(k,1) = phi;   
 Ec(k,2) = val; %field inside the shell
 phi = phi + 0.5; 
end

figure(3)
plot(Ec(:,1),Ec(:,2),'-k', 'LineWidth', 2 )
xlabel( '\phi, degrees' , 'FontSize', 14)
%ylabel( '|E/Ei| in the shell' , 'FontSize', 14)
ylabel( '|E/Ei| at (ra+rb)/2' , 'FontSize', 14)

grid on;
%set(gca,'XTick', 0:20:200, 'FontSize', 14)
%set(gca,'YTick', 'FontSize', 14 )
%axis( [0 200 0.6 1.6]);

% calculate NRCS
phi = 0.;
for i = 1 : 361
 W(i,1) = phi;   
 W(i,2) = nrcs( phi , E , x , y , k0 , a , eps );   
 phi = phi + 0.5; 
end
W(:,2) = W(:,2)/Lam;  % like in the paper

if ( strcmp(wave_kind,'cylindrical')==1 )
%    W(:,2) = W(:,2) / (1./(120*pi*pi*k0*ro0));
     W(:,2) = W(:,2) / ( abs( besselh(0,1,k0*ro0) ) )^2 ;
end

figure(4)
plot(W(:,1),W(:,2),'-k', 'LineWidth', 2 )
xlabel( '\phi, degrees' , 'FontSize', 14)
ylabel( 'Echo Width/Wavelength, m' , 'FontSize', 14)

grid on;
%axis([0 200 0 1]);
%set(gca,'XTick', 0:20:200)
%set(gca,'YTick', 0:0.2:1,'FontSize', 14 )


figure(2)
%imagesc(abs(Es));
imagesc(xx(1,:) ,yy(:,1),aE_tot);
set(gca,'YDir','normal')
axis image;
caxis([0 2]);
axis([-d d -d d]);
colorbar;
xlabel( 'X, \lambda' ,'FontSize', 14)
ylabel( 'Y, \lambda' ,'FontSize', 14)
set(gca, 'FontSize', 14);
hold on;
rectangle('Position',[-ra,-rb,2*ra,2*rb],'LineWidth', 2, 'LineStyle', '--')

figure(1)
% plot points
plot(x,y,'x','MarkerSize',5,'Color','r');
% plot cells
for i = 1 : N
rectangle('Position',[x(i) - 0.5*l,y(i)-0.5*l,l,l])
end
hold on;
%axis([-1.2*rb 1.2*rb -1.2*rb 1.2*rb ])
axis([-d d -d d ])
axis square;
xlabel( 'X, m' ,'FontSize', 14)
ylabel( 'Y, m' ,'FontSize', 14)
set(gca, 'FontSize', 14);