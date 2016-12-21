%% Q5iii.m
%    Demonstrates Restarted Generalized Minimum Residual Method (GMRES) 
%       with Outer Residual Monitoring/Tracking and QR by Givens
%       with Arnoldi process based on Modified-Gram Schmidt Process
%
%
%       Course:     ECE 7650
%       Homework:   Final Exam
%       Sub. Date:  December 18, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

close all; clear; clc;

%% set parameters 
dim = 1000;                                                                  % input matrix dimension
A = smatrix(dim);                                                           % set matrix A to be loaded matrix
b = randn(dim, 1);                                                          % set b to be the loaded RHS
x0 = randn(length(b), 1);                                                   % set initial guess
tol = 1e-6;                                                                % set error tolerance expected
m = 10;                                                                      % number of required Krylov basis
maxItr = 40;                                                                % maximum number of iterations expected


%% solve the system of equation
[x, itr, itri, err] = gmresrestart(A, x0, b, m, maxItr, tol);               % solve the system with Restarted GMRES                         

xe = A\b;                                                                   % exact solution (from backslash operator)


%% output the results
disp(' ');

disp('*************** Proofs that Implementation works  ****************');
disp(['Norm(x - xe):                   ', num2str(norm(x - xe))]);

