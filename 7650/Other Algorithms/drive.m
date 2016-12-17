clear; clc;
load('data/S.mat');
load('data/RHS.mat');

%% set parameters 
A = S;
b = RHS;
x0 = zeros(length(b), 1);
maxItr = 200;
tol = 1e-3;
m = 70;


%% solve the system of equation
[x, H, v, j] = fomrest(A, x0, b, m, tol);
% [x, H, v] = fom(A, x0, b, m);
% [x, itr, err] = sd(A, b, x0, maxItr, tol);
% [x, itr, err] = rnsd(A, b, x0, maxItr, tol);              % convergence is extremely slow
% [x, itr, err] = minRes(A, b, x0, maxItr, tol);

x1 = A\b;

abs(x1 - x)