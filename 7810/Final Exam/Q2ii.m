%% Q1d.m
%   Demonstrate Iterative schemes for solving Vandermonde matrix
%
%       Schemes: Jacobi, Gauss-Siedel and SOR 
%        
%       Course:     ECE 7810 Final Exam
%       Sub. Date:  January 6, 2017
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca
close all; clear; clc;


%% set parameters
X = zeros(4, 1);                                                            % initial guess

%% JACOBI SCHEME
% first iteration for update equation
k = 1;
x(:, :, k) = X;
k = 2;
x(1, :, k) = 1 - (x(2) + x(3) + x(4));
x(2, :, k) = 1 - 0.5*(x(1) + 4*x(3) + 8*x(4));
x(3, :, k) = 1 - (1/9)*(x(1) + 3*x(2) + 27*x(4));
x(4, :, k) = 1 - (1/64)*(x(1) + 4*x(2) + 16*x(3));

disp('Jacobi Scheme for the first update: ');
x = x(:,:, k)


%% GAUSS-SIEDEL SCHEME
% first iteration for update equation
x = X;
x(1) = 1 - (x(2) + x(3) + x(4));
x(2) = 1 - 0.5*(x(1) + 4*x(3) + 8*x(4));
x(3) = 1 - (1/9)*(x(1) + 3*x(2) + 27*x(4));
x(4) = 1 - (1/64)*(x(1) + 4*x(2) + 16*x(3));

disp('Gauss-Siedel Scheme for the first update: ');
x


%% SOR (Successive Over-Relaxation) SCHEME
% first iteration for update equation
x = X;
w = 1.65;                                               % overrelaxation factor
x(1) = w*((1 - (x(2) + x(3) + x(4))) - x(1)) + x(1);
x(2) = w*((1 - 0.5*(x(1) + 4*x(3) + 8*x(4))) - x(2)) + x(2);
x(3) = w*((1 - (1/9)*(x(1) + 3*x(2) + 27*x(4))) - x(3)) + x(3);
x(4) = w*((1 - (1/64)*(x(1) + 4*x(2) + 16*x(3))) - x(4)) + x(4);

disp('SOR Scheme for the first update: ');
x
