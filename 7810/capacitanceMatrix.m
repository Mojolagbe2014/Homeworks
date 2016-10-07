%% capacitanceMatrix.m
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
max_iter = 1000;    % maximum iterations 
ep_0 = 8.85e-12;    % absolute dielectric constant
epsilon = 1e-6;     % ralative displacement norm
V0 = 100;           % potential on capacitor 1
V1 = 0;             % voltage on capacitor 2

width = 15;         % width of the rectangle
height = 25;        % height of the rectangle
h = 1;              % grid Resolution 
c1_start = 6;       % start of conductor 1
c1_end = 11;        % end of conductor 1
c2_start = 16;      % start of conductor 2
c2_end = 21;        % end of conductor 2
c_start_y = 8;      % start y co-ordinate of the conductors
c_end_y = 9;        % end y co-ordinate of the conductors

%% calculate number of grid point and set the grid

nx = (width/h) + 1;         % number of points in x direction
ny = (height/h) + 1;        % number of points in y direction

phi = zeros(nx, ny);        % grid/solution matrix phi(x,y) %% ones(nx-1, ny-1);

%% set boundary condition on the conductors 
phi(c_start_y, c1_start:c1_end)=V0;                     % top of left conductor
phi(c_end_y, c1_start:c1_end)=V0;                       % bottom of left conductor
phi(c_start_y, c2_start:c2_end)=V1;                     % top of right conductor
phi(c_end_y, c2_start:c2_end)=V1;                       % bottom of right conductor


%% solve the grid matrix with SOR
iter = 1;           % counter for the number iterations
err_norm = 99999;   % error norm for stoping the iterations

while(iter < max_iter && err_norm > epsilon)
    ph =  0;        % solution norm
    disp_norm = 0;  % displacement norm
    
    % loop over inner matrix
    for i = 2:1:nx-1
        for j = 2:1:ny-1
            residual =  (phi(i - 1, j) +  phi(i + 1, j) +  phi(i, j - 1) + phi(i, j + 1)) ./ 4;
            acc_residual = omega * (residual - phi(i, j));
            phi(i, j) = phi(i, j) + acc_residual;
            phi(c_start_y, c1_start:c1_end)=V0;                     % top of left conducter
            phi(c_end_y, c1_start:c1_end)=V0;                     % bottom of left conducter
            phi(c_start_y, c2_start:c2_end)=V1;                    % top of right conducter
            phi(c_end_y, c2_start:c2_end)=V1;                    % bottom of right conducter
            
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
% whole region flux
flux = 0;
flux = flux + sum(phi(1, :)) + sum(phi(:, 1)) + sum(phi(nx, :)) + sum(phi(:, ny));          % outside potential
flux = flux - sum(phi(2, :)) - sum(phi(:, 2)) - sum(phi(nx-1, :)) - sum(phi(:, ny-1));      % inside potential
flux = -ep_0*flux;

% capacitor 1 flux & volume charge density
 c1_flux = 0;
Q1 = -ep_0*(sum(phi(7, 6:11))+sum(phi(10,6:11))+phi(8,5)+phi(9,5)+phi(8,12)+phi(9,12)-...
    sum(phi(8,6:11))-sum(phi(9,6:11)));
Q2 = -ep_0*(sum(phi(7,16:21))+sum(phi(10,16:21))+phi(8,15)+phi(9,15)+phi(8,22)+phi(9,22)-...
    sum(phi(8,16:21))-sum(phi(9,16:21)));

%% output the result
disp(['Total electric flux from the region: ', num2str((flux))]);
disp(' ');
disp(['Q1                                  : ', num2str((Q1))]);
disp(['Q2                                  : ', num2str((Q2))]);

C11 = Q1/V0;
C21 = Q2/V0;
C22=C11;                        % because of symmetry
C12=C21;                        % because of symmetry
capacitance_matrix = [C11 C12;C21 C22] % capacitance matrix

% show the flux diagram
figure
imagesc(phi),colorbar
set(gca,'YDir','normal')
rectangle('Position',[6 8 5 1])
rectangle('Position',[16 8 5 1])
[px,py]=gradient(phi);
hold
quiver(px,py)

