%% Q4iii.m
%    Demonstrates Lanczos form of FOM with Tm=LmUm
%       has an improved performance over FOM (Full Orthogonalization Method) 
%       [For the 2 cases inner residual monitoring is implemented]
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

%% load data obtained from Second Order FEM  of a problem or use random matrix
% load('data/S.mat');
% load('data/RHS.mat');
dim = 100;
S = smatrix(dim);
RHS = randn(dim, 1);


%% set parameters 
A = S;                                                                      % set matrix A to be loaded matrix
b = RHS;                                                                    % set b to be the loaded RHS
x0 = randn(length(b), 1);                                                   % set initial guess
tol = 1e-6;                                                                 % set error tolerance expected
m = 20;                                                                     % number of required Krylov basis

%% solve the system of equation
tic
[x, itr, err, ~] = lanczosfom(A, x0, b, m, tol);                              % solve the system of equation with Lanczos variant
tlan = toc;
tic
[x1, ~, ~, itr2, err2] = fomrest(A, x0, b, m, tol);                                   
tfom = toc;

xe = A\b;                                                                   % exact solution (from backslash operator)


%% output the results
disp(['============= Timetaken  m = ',num2str(m),' and tol = ',num2str(tol),' ===============']);
disp(['FOM based on Modified Gram Schmidt:        ', num2str(tfom)]);
disp(['FOM based on Lanczos Method (LU):          ', num2str(tlan)]);
disp(' ');

disp('*************** Proofs that Implementation works  ****************');
disp(['Norm(x - xe):                   ', num2str(norm(x - xe))]);
disp(['Norm(x1 -xe):                   ', num2str(norm(x1 -xe))]);

disp(' ');

disp('*************** Number of Iterations Completed  ****************');
disp(['FOM based on Modified Gram Schmidt:        ', num2str(itr2)]);
disp(['FOM based on Lanczos Method (LU):          ', num2str(itr)]);

% plot the results
fomItr = 1:itr2;
lanItr = 1:itr;
plot(fomItr, err2, '-b', lanItr, err, '--r');
title('Convergence of FOM based on MGS and FOM based on Lanczos');
xlabel('Iteration Count');
ylabel('Error');
legend('FOM based on Modified Gram Schmidt', 'FOM based on Lanczos Method (LU)');


