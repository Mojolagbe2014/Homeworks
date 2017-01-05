%% Q1d.m
%   Solving Vandermonde matrix with Congugate Gradient Method
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
A = [1 1 1 1; 1 2 4 8; 1 3 9 27; 1 4 16 64];                                % given matrix
b = ones(4, 1);                                                             % RHS
x = zeros(4, 1);                                                            % initial guess

%% Conjugate Gradient SCHEME
% first iteration for update equation
k = 1;
r = b - (A*x);
beta = A*r;
alpha = (norm(r).^2)/dot(r, beta);
x = x + alpha*r;

disp('First Update solution: ');
x

% second iteration for update equation
r = r - alpha*beta;
k = 2;
alpha = (norm(r).^2)/dot(r, A*r);
x = x + alpha*r;

disp('Second Update solution: ');
x