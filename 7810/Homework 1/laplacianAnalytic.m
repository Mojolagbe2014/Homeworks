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
V0 = 100;           % applied potential
h = 0.1;            % grid resolution/discretization
omega = 1.54;       % over relaxation constant
width = 1;          % grid width
height = 1;         % grid height
guess = 1;          % initial guess 
max_iter = 10;   % maximum number of iteration

%%  call solveAnalytic function
[phi, nx, ny] = solveAnalytic(width, height, h, 0, 0, V0, 0, V0, max_iter);
phi = phi';
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