%% laplacianCapacitanceMatrix.m
%    Solve for the capacitance matrix of transmission line
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

%%  set variables

omega = 1.54;       % over-relaxation constant / acceleration factor (this value is not used)
max_iter = 100;     % maximum iterations 
epsolon = 1e-6;     % ralative displacement norm
V0 = 100;           % potential on the capacitors

width = 25;         % width of the rectangle
height = 15;        % height of the rectangle
h = 1;              % grid Resolution 

c_width = 5;     % width of the conductors
c_height = 1;    % height of the conductors

c_start_y = floor(height/2);         % center the capacitors at the center of y - axis
c_end_y = c_start_y + c_height;      % vertical end of the capacitors

c1_start = 5;                       % start of capacitor 1 on x-axis
c1_end = c1_start + c_width;        % end of capacitor 1 on x-axis

c2_start = c1_end + c_width + 1;    % start of capacitor 2 on x-axis
c2_end = c2_start + c_width;        % end of capacitor 2 on x-axis

% set boundary condition voltages for the rectangle
a = 0;        % left 
b = 0;        % top 
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


%% initial guess for the grid matrix, set initial value to 0 for non-boundary elements
for i = 2:1:nx-1
    for j = 2:1:ny-1
        phi(i, j) = 0;
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
        for j = 2:1:ny-1
            residual =  (phi(i - 1, j) +  phi(i + 1, j) +  phi(i, j - 1) + phi(i, j + 1)) ./ 4;
            acc_residual = omega * (residual - phi(i, j));
            phi(i, j) = phi(i, j) + acc_residual;
            phi(c1_start:c1_end, c_start_y:c_end_y) = V0;           % set capacitor 1 potential
            phi(c2_start:c2_end, c_start_y:c_end_y) = -V0;          % set capacitor 2 potential
            
            ph = abs(ph) + abs(phi(i, j));                          % calculate current solution norm
            disp_norm = abs(disp_norm) + abs(acc_residual);         % calculate displacement norm
        end
    end
    
    % calculate relative displacement norm
    err_norm = disp_norm / ph;
    %increment the counter
    iter = iter + 1;
end

%% calculate the total flux emanating from the region
% flux = 0;       % initialize total flux to zero
% for i = 1:1:nx
%     flux = flux + phi(1, i) + phi(i, 1) + phi(nx, i) + phi(i, ny);          % outside potential
%     flux = flux - phi(2, i) - phi(i, 2) - phi(nx-1, i) - phi(i, ny-1);      % inside potential
% end
% 
% 
% %% output the result
% disp(['Total flux: ', num2str(abs(flux))]);

                                                                      
%% output results
figure
imagesc(phi'),colorbar
set(gca,'YDir','normal')
rectangle('Position',[c1_start c_start_y c_width c_height])
rectangle('Position',[c2_start c_start_y c_width c_height])
[px,py]=gradient(phi');
hold
quiver(px,py)
