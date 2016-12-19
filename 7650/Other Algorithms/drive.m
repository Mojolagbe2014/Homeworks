clear; clc;
load('data/S.mat');
load('data/RHS.mat');

%% set parameters 
A = S;
b = RHS;
x0 = ones(length(b), 1);
maxItr = 40;
tol = 1e-6;
m = 40;
decType = 1;


%% solve the system of equation

% [x, j, err, v] = lanczosfom(A, x0, b, m, tol);
% [x, itr, err, H, v] = gmresrm(A, x0, b, m, maxItr, tol, decType);
% [x, H, v] = gmres(A, x0, b, m, decType);
% [x, itr2, err, H, v] = fomrestart(A, x0, b, m, maxItr, tol);
[x, H, v, j] = fomrest(A, x0, b, m, tol);
% [x, H, v] = fom(A, x0, b, m)        ;
% [x, itr, err] = sd(A, b, x0, maxItr, tol);
% [x, itr, err] = rnsd(A, b, x0, maxItr, tol);              % convergence is extremely slow
% [x, itr, err] = minres(A, b, x0, maxItr, tol);

% x1 = A\b;
% abs(x1 - x)