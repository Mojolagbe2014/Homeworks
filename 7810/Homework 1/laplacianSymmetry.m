%% laplacianSymmetry.m
%   Calculate solve for the scalar potential,phi(x,y) 
%    on a rectangular grid using Successive Over-Relaxation (SOR) with Symmetry.
%       
%       Approach: Numerical Solution
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
tic
%%  set variables

omega = 1.54;        % over-relaxation constant / acceleration factor (this value is not used)
max_iter = 100;     % maximum iterations 
epsolon = 1e-6;     % ralative displacement norm

width = 1;      % width of the rectangle
height = 1;     % height of the rectangle
h = 0.1;        % grid Resolution 

% set boundary condition voltages for the rectangle
a = 0;        % left 
b = 100;        % top 
c = 0;        % right
d = 0;        % bottom 

%% calculate number of grid point and set the grid

nx = (width/h) + 1;         % number of points in x direction
ny = (height/h) + 1;        % number of points in y direction

ny = ceil(ny/2);            % get the plane of symmetry

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
% phi(1, ny) = (b+c)/2;


%% initial guess for the grid matrix, set initial value to 1.0 for non-boundary elements
for i = 2:1:nx-1
    for j = 2:1:ny
        phi(i, j) = 1.0;
    end
end

% phi(2 : nx - 2, 2 : ny - 2) = 1.0;

%% solve the grid matrix with SOR
iter = 1;           % counter for the number iterations
err_norm = 99999;   % error norm for stoping the iterations

while(iter < max_iter && err_norm > epsolon)
    ph =  0;        % solution norm
    disp_norm = 0;  % displacement norm
    
    % loop over inner matrix
    for i = 2:1:nx-1
        for j = 2:1:ny
            if j < ny
                residual =  (phi(i - 1, j) +  phi(i + 1, j) +  phi(i, j - 1) + phi(i, j + 1)) ./ 4;
            else
                residual =  (phi(i - 1, j) +  phi(i + 1, j) +  phi(i, j - 1) + phi(i, j - 1)) ./ 4;
            end
            acc_residual = omega * (residual - phi(i, j));
            phi(i, j) = phi(i, j) + acc_residual;
            
            ph = abs(ph) + abs(phi(i, j));                          % calculate current solution norm
            disp_norm = abs(disp_norm) + abs(acc_residual);         % calculate displacement norm
        end
    end
    
    % calculate relative displacement norm
    err_norm = disp_norm / ph;
    %increment the counter
    iter = iter + 1;
end