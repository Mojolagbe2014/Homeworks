clear; clc;
load('data/S.mat');
load('data/RHS.mat');

%% set parameters 
A = S;
b = RHS;
x0 = zeros(length(b), 1);
maxItr = 4;
tol = 1e-9;
m = 10;
decType = 2;


%% solve the system of equation
[x, itr, err, H, v] = gmresrm(A, x0, b, m, maxItr, tol, decType);
% [x, H, v] = gmres(A, x0, b, m, decType);
% [x, itr, err, H, v] = fomrestart(A, x0, b, m, maxItr, tol);
% [x, H, v, j] = fomrest(A, x0, b, m, tol);
% [x, H, v] = fom(A, x0, b, m);
% [x, itr, err] = sd(A, b, x0, maxItr, tol);
% [x, itr, err] = rnsd(A, b, x0, maxItr, tol);              % convergence is extremely slow
% [x, itr, err] = minres(A, b, x0, maxItr, tol);

x1 = A\b;

abs(x1 - x)