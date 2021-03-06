%% laplacianCapacitanceMatrix.m
%    Solve for the capacitance matrix of transmission line
%    of 2D problem having dielectric discontinuities
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
max_iter = 8000;     % maximum iterations 
ep_0 = 8.85e-12;    % absolute dielectric constant
ep_1 = 10.0;
ep_2 = 4.7;
ep_  = 10.0;

ep_1 = ep_1 * ep_0; % relative dieletric constant 1
ep_2 = ep_2 * ep_0; % relative dieletric constant 2
ep_ = ep_ * ep_0;   % relative dieletric constant for ep_
epsilon = 1e-6;     % relative displacement norm
V0 = 100;           % potential on the conductors
V1 = 0;

width = 30;         % width of the rectangle
height = 5;         % height of the rectangle
h = 0.5;            % grid Resolution 

c_width = 3;       % width of the conductors
c_height = 0.5;    % height of the conductors
c_gap = 4;         % distance between the two conductors

c_start_y = (2.5)/h;         % center the capacitors at the center of y - axis
c_end_y = c_start_y + (c_height/h);      % vertical end of the capacitors

c1_start = 10/h;                       % start of capacitor 1 on x-axis
c1_end = c1_start + c_width/h;        % end of capacitor 1 on x-axis

c2_start = c1_end + c_gap/h + 1;     % start of capacitor 2 on x-axis
c2_end = c2_start + c_width/h;        % end of capacitor 2 on x-axis

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
 phi(c1_start:c1_end, c_start_y:c_end_y) = V0;           % set capacitor 1 potential
 phi(c2_start:c2_end, c_start_y:c_end_y) = V1;          % set capacitor 2 potential
%% solve the grid matrix with SOR
iter = 1;           % counter for the number iterations
err_norm = 99999;   % error norm for stoping the iterations

while(iter < max_iter && err_norm > epsilon)
    ph =  0;        % solution norm
    disp_norm = 0;  % displacement norm
    
    % loop over inner matrix
    for i = 2:1:nx-1
        for j = 2:1:ny-1
            residual =  (phi(i - 1, j) +  phi(i + 1, j) +  phi(i, j - 1) + phi(i, j + 1) - (4*phi(i, j))) ./ 4;
            if i == (c1_start - (0.5/h)) && j < c_start_y
                ep_av = (ep_ + ep_1)./2;
                residual = (ep_av*phi(i,j+1) + ep_1*phi(i+1,j) + ep_av*phi(i,j-1) + ep_*phi(i-1,j) - 4*ep_av*phi(i,j))./4*ep_av;
            elseif i == (c1_end + (0.5/h)) && j < c_start_y
                ep_av = (ep_ + ep_1)./2;
                residual = (ep_av*phi(i,j+1) + ep_*phi(i+1,j) + ep_av*phi(i,j-1) + ep_1*phi(i-1,j) - 4*ep_av*phi(i,j))./4*ep_av;
            elseif i == (c2_start - (0.5/h)) && j < c_start_y
                ep_av = (ep_ + ep_2)./2;
                residual = (ep_av*phi(i,j+1) + ep_2*phi(i+1,j) + ep_av*phi(i,j-1) + ep_*phi(i-1,j) - 4*ep_av*phi(i,j))./4*ep_av;
            elseif i == (c2_end + (0.5/h)) && j < c_start_y
                ep_av = (ep_ + ep_2)./2;
                residual = (ep_av*phi(i,j+1) + ep_*phi(i+1,j) + ep_av*phi(i,j-1) + ep_2*phi(i-1,j) - 4*ep_av*phi(i,j))./4*ep_av;
            elseif i ~= (c1_start - (0.5/h)) && i ~= (c2_start - (0.5/h)) && i ~= (c1_end + (0.5/h)) && i ~= (c2_end + (0.5/h)) && j == c_start_y
                ep_av = (ep_)./2; ep_avc = (2*ep_av + ep_ + 1)./4;
                residual = (phi(i,j+1) + ep_av*phi(i+1,j) + ep_*phi(i,j-1) + ep_av*phi(i-1,j) - 4*ep_avc*phi(i,j))./4*ep_avc;
            elseif i == (c1_start - (0.5/h)) && j == c_start_y
                ep1 = ep_/2; ep2 = ep_1/2; ep_av = (ep_+ep_1)./2; ep_avc = (ep_av + 1);
                residual = (phi(i,j+1) + ep2*phi(i+1,j) + ep_av*phi(i,j-1) + ep_1*phi(i-1,j) - ep_avc*phi(i,j))./ep_avc;
            elseif i == (c1_end + (0.5/h)) && j == c_start_y
                ep1 = ep_/2; ep2 = ep_1/2; ep_av = (ep_+ep_1)./2; ep_avc = (ep_av + 1);
                residual = (phi(i,j+1) + ep1*phi(i+1,j) + ep_av*phi(i,j-1) + ep_2*phi(i-1,j) - ep_avc*phi(i,j))./ep_avc;
            elseif i == (c2_start - (0.5/h)) && j == c_start_y
                ep1 = ep_/2; ep2 = ep_2/2; ep_av = (ep_+ep_2)./2; ep_avc = (ep_av + 1);
                residual = (phi(i,j+1) + ep2*phi(i+1,j) + ep_av*phi(i,j-1) + ep_1*phi(i-1,j) - ep_avc*phi(i,j))./ep_avc;
            elseif i == (c2_end + (0.5/h)) && j == c_start_y
                ep1 = ep_/2; ep2 = ep_2/2; ep_av = (ep_+ep_2)./2; ep_avc = (ep_av + 1);
                residual = (phi(i,j+1) + ep1*phi(i+1,j) + ep_av*phi(i,j-1) + ep_2*phi(i-1,j) - ep_avc*phi(i,j))./ep_avc;
            elseif i > (c1_start - (0.5/h)) && i < (c1_end + (0.5/h)) && j == c_start_y
                ep_av = (ep_1)./2; ep_avc = (2*ep_av + ep_1 + 1)./4;
                residual = (phi(i,j+1) + ep_av*phi(i+1,j) + ep_1*phi(i,j-1) + ep_av*phi(i-1,j) - 4*ep_avc*phi(i,j))./4*ep_avc;
            elseif i > (c2_start - (0.5/h)) && i < (c2_end + (0.5/h)) && j == c_start_y
                ep_av = (ep_2)./2; ep_avc = (2*ep_av + ep_2 + 1)./4;
                residual = (phi(i,j+1) + ep_av*phi(i+1,j) + ep_2*phi(i,j-1) + ep_av*phi(i-1,j) - 4*ep_avc*phi(i,j))./4*ep_avc;
            end
            
            acc_residual = omega * (residual);
            phi(i, j) = phi(i, j) + acc_residual;
            phi(c1_start:c1_end, c_start_y:c_end_y) = V0;           % set capacitor 1 potential
            phi(c2_start:c2_end, c_start_y:c_end_y) = V1;          % set capacitor 2 potential
            
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
flux = -ep_0 * flux;

% capacitor 1 flux & volume charge density
c1_flux = 0;
c1_flux = c1_flux + sum(phi(c1_start-1, c_start_y-1:c_end_y+1)) + sum(phi(c1_end+1, c_start_y-1:c_end_y+1)) ...
        + sum(phi(c1_start-1:c1_end+1, c_start_y-1)) + sum(phi(c1_start-1:c1_end+1, c_end_y+1));          % outside potential
c1_flux = c1_flux - sum(phi(c1_start+1, c_start_y+1:c_end_y-1)) - sum(phi(c1_end-1, c_start_y+1:c_end_y-1)) ...
        - sum(phi(c1_start+1:c1_end-1, c_start_y+1)) - sum(phi(c1_start+1:c1_end-1, c_end_y-1));      % inside potential
Q1 = ep_0*c1_flux;


% capacitor 2 flux & volume charge density
c2_flux = 0;
c2_flux = c2_flux + sum(phi(c2_start-1, c_start_y-1:c_end_y+1)) + sum(phi(c2_end+1, c_start_y-1:c_end_y+1)) ...
        + sum(phi(c2_start-1:c2_end+1, c_start_y-1)) + sum(phi(c2_start-1:c2_end+1, c_end_y+1));          % outside potential
c2_flux = c2_flux - sum(phi(c2_start+1, c_start_y+1:c_end_y-1)) - sum(phi(c2_end-1, c_start_y+1:c_end_y-1)) ...
        - sum(phi(c2_start+1:c2_end-1, c_start_y+1)) - sum(phi(c2_start+1:c2_end-1, c_end_y-1));      % inside potential
Q2 = ep_0*c2_flux;

%% output the result
disp(['Total electric flux density from the region: ', num2str((flux))]);
disp(' ');
disp(['Q1                                         : ', num2str((Q1))]);
disp(['Q2                                         : ', num2str((Q2))]);

C11 = Q1/V0;
C21 = Q2/V0;
C22=C11;                                % because of symmetry
C12=C21;                                % because of symmetry
capacitance_matrix = [C11 C12;C21 C22]  % capacitance matrix
phi=phi';