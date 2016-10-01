%% laplacianNumeric.m
%   Calculate solve for the scalar potential,phi(x,y) 
%    on a rectangular grid using Successive Over-Relaxation (SOR).
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

omega = 1;                          % over-relaxation constant / acceleration factor
omega_count = 1;                    % iteration counter for storing omega values 
omega_array = omega : 0.01: 1.9;    % array of relaxation factors to be used for ploting

for omega = omega : 0.01 : 1.9           % loop through the solver using different omega values
    %% solve with SOR
    [phi, iter, nx, ny] = solveSOR(1, 1, 0.1, 0, 0, 100, 0, 1, omega, 1e-6, 100);
    
    iter_array(omega_count) = iter;               % store the number of iterations for each omega value
    omega_count = omega_count + 1;                % increment the omega loop counter
end


%% calculate the total flux emanating from the region
flux = 0;       % initialize total flux to zero
for i = 1:1:nx
    flux = flux + phi(1, i) + phi(i, 1) + phi(nx, i) + phi(i, ny);          % outside potential
    flux = flux - phi(2, i) - phi(i, 2) - phi(nx-1, i) - phi(i, ny-1);      % inside potential
end


%% find the index of optimum over-relaxation constant

indexmin = find(min(iter_array) == iter_array);     % find the minimum number of iteration       
omega_min = omega_array(indexmin);                  % get minimum over-relaxation value
itera_min = iter_array(indexmin);                   % get minimum number of iterations


%% output the result
disp(['Total flux: ', num2str(abs(flux))]);
disp(' ');
disp(['Optimum over-relaxation constant: ', num2str(omega_min), ...
    ' [No of iterations: ', num2str(itera_min), ']']);
    
% plot the relaxation factor againt number of iterations
% subplot(2, 2, 1);
plot(omega_array, iter_array, 'b');
title('The graph of over-relaxation factor (\omega) against number of iterations (k)');
xlabel('Over-relaxation factor (\omega)');
ylabel('Number of iterations (k)');
grid on

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


