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


%%  call solveAnalytic function
[phi, nx, ny] = solveAnalytic(1, 1, 0.1, 0, 0, 100, 0, 100, 10);

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