%% laplacianAnalytic.m
%   Calculate solve for the scalar potential,phi(x,y) 
%   on a rectangular grid using Analytical solution.
%       
%       Approach: Analytical Solution
%        
%       Course:     ECE 7810
%       Homework:   1
%       Sub. Date:  October 4, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

clear; clc; close all;


%%  set variables

omega = 1.5;        % over-relaxation constant / acceleration factor
max_iter = 20;      % maximum iterations 
absolon = 1e-10;    % ralative displacement norm

width = 1;      % width of the rectangle
height = 1;     % height of the rectangle
h = 0.1;        % grid Resolution

% set boundary condition voltages for the rectangle
a = 0;        % left 
b = 0;      % top 
c = 100;        % right
d = 0;        % bottom        
V0 = c;


%% calculate number of grid point and set the grid

nx = (width/h) + 1;         % number of points in x direction
ny = (height/h) + 1;        % number of points in y direction

phi = zeros(nx, ny);    % grid/solution matrix phi(x,y) %% ones(nx-1, ny-1);



%% set boundary condition (Dirichlet B. C)

% non-corner elemets at the boundary
phi(:,1) = a;        % bottom
phi(:,ny) = c;     % top
phi(1,:) = b;        % left
phi(nx,:)= d;      % right

% corner elements at the boundary
phi(1, 1) = (a+b)/2;
phi(nx, 1) = (a+d)/2;
phi(nx, ny) = (c+d)/2;
phi(1, ny) = (b+c)/2;


%% solve the grid matrix with analytic solution

for i = 1:1:nx-1
    for j = 1:1:ny-1
        sigma = 0;
        for n = 1:2:max_iter
            sigma = sigma + (sin((n*pi*h*i)./width) * sinh((n*pi*h*j)./width)) ./ (n * sinh((n*pi*height)./width));
        end
        if i+1~=1 && j+1~=1 && i+1~= nx && j+1~=ny
            phi(i+1, j+1) =  ((4 * V0)./pi) *  sigma; 
        end
    end
end

%% output the result
% phi

% plot potential distribution with contour 
xv = 0:10:100;
yv = 0:10:100;
% subplot(2, 2, 2);
figure
contour(xv,yv,phi,'ShowText','on');
title('Potential Distribution (Contour)');
xlabel('V (volts)');
ylabel('V (volts)');
grid on

% subplot(2, 2, 3);
figure
grad = gradient(phi);
mesh(xv,yv,phi,grad);
title('Potential Distribution (Mesh)');
xlabel('V (volts)');
ylabel('V (volts)');
zlabel('V (volts)');