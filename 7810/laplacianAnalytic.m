%% laplacianAnalytic.m
%   Calculate solve for the scalar potential,phi(x,y) 
%   on a rectangular grid using Successive Over-Relaxation (SOR).
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
max_iter = 500;     % maximum iterations 
absolon = 1e-10;    % ralative displacement norm

width = 1;      % width of the rectangle
height = 1;     % height of the rectangle
h = 0.1;        % grid Resolution 

% set boundary condition voltages for the rectangle
a = 0;        % left 
b = 100;      % top 
c = 0;        % right
d = 0;        % bottom 

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
% ser = 50;Vs=0;V0=100;
% for i=1:nx-1
%     for j=1:ny-1
%         if i~=1 && j~=1 && i~=nx-1 && j~=ny-1  
%         x=h*i;
%         y=h*j;
%         for k=1:ser;
%             n=2*k-1;
%             Vs=Vs+(4*V0/pi*((sin(n*pi*x./width)*sinh(n*pi*y./width))./(n*sinh(n*pi*height./width))));
%         end
%         phi(i, j) = Vs;
%         Vs=0;
%         end
%     end
% end
 % loop over inner matrix
    for i = 2:1:nx-1
        for j = 2:1:ny-1
            residual =  (phi(i - 1, j) +  phi(i + 1, j) +  phi(i, j - 1) + phi(i, j + 1)) ./ 4;
            acc_residual = omega * (residual - phi(i, j));
            phi(i, j) = phi(i, j) + acc_residual;
            
            ph = abs(ph) + abs(phi(i, j));                          % calculate current solution norm
            disp_norm = abs(disp_norm) + abs(acc_residual);         % calculate displacement norm
        end
    end

%% output the result
% phi