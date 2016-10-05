%% sparseVsSOR.m
%   Testing computational efficiency of 
%       Sparse Matrix Vs SOR techniques
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

%% set parameters
V0 = 100;           % applied potential
h = 0.25;            % grid resolution/discretization
omega = 1.54;       % over relaxation constant
width = 1;          % grid width
height = 1;         % grid height
eps = 1e-6;         % relative displacement norm (for SOR technique only)
guess = 1;          % initial guess (for SOR technique technique only)
max_iter = 100;     % maximum number of iterations (for SOR technique technique only)
rhs = 0;            % the right handside of the laplacian problem (for sparse matrix technique technique only)

%% solve with SOR
tic
[phi_sor, iter, nx_sor, ny_sor] = solveSOR(width, height, h, 0, V0, 0, 0, guess, omega, eps, max_iter);
toc

tic
%% compute sparse matrix
[phi, bi, nx, ny] = computeSparse(width,height,h,0,0,V0,0,0);
phi = sparse(phi);
% tic
%% solve the resulting sparse matrix with A\b
ph = phi\bi;
toc

%% fill the sparse matrix with the calculated potentials
% ph = ph';         
% ph = reshape(ph, nx, ny);
% ph = ph';
% % ph = vec2mat(phi, ny);

%% output the results
% execution time (in seconds) for various levels of discretizations
h_arr = [0.01, 0.02, 0.025, 0.05, 0.1, 0.2, 0.25];                                  % resolution
sor_arr = [0.048300, 0.012971, 0.009860, 0.002526, 0.001127, 0.000810, 0.000781];   % sor time
ab_1 =  [0.027240, 0.005580, 0.003316, 0.000880, 0.000493, 0.000171, 0.000310];     % a\b time without sparse matrix generation time
ab_2 = [4.184827, 0.264360, 0.105036, 0.007524, 0.001754, 0.001134, 0.00923];       % a\b time with sparse matrix generation time

figure
plot (sor_arr, h_arr, '-r', ab_1, h_arr, '-b');
title('The graph of grid resolution against both SOR and sparse techniques');
xlabel('Grid resolution (h)');
ylabel('Timetaken in second, t(s)');
legend('SOR', 'Sparse Matrix');

