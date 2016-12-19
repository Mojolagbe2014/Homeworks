clear; clc;
load('data/S.mat');
load('data/RHS.mat');

%% set parameters 
A = S;
b = RHS;
x0 = ones(length(b), 1);
maxItr = 40;
tol = 1e-2;
m = 15;
decType = 1;


%% solve the system of equation
% [x, itr, err, H, v] = gmresrm(A, x0, b, m, maxItr, tol, decType);
% [x, H, v] = gmres(A, x0, b, m, decType);
% [x, itr2, err, H, v] = fomrestart(A, x0, b, m, maxItr, tol);
% [x, H, v, j] = fomrest(A, x0, b, m, tol);
% [x, H, v] = fom(A, x0, b, m)        ;
% [x, itr, err] = sd(A, b, x0, maxItr, tol);
% [x, itr, err] = rnsd(A, b, x0, maxItr, tol);              % convergence is extremely slow
% [x, itr, err] = minres(A, b, x0, maxItr, tol);
n = 7;
A = exp(1i * pi * randn(n, n));         
A = 0.5*(A+A');
A = A + n*eye(n);
b = randn(n, 1); 
m = 5; 
r = b;
beta = norm(r);
x0 = r./beta;
tic
[H, v2] = arnoldi(A, x0, m);
toc
tic
[a, v] = lanczos(A, x0, m);
toc
% x1 = A\b;
% abs(x1 - x)
% Hm = H(1:m,1:m);
% Vm = v(:,1:m);
% Hvm = Vm*Hm*Vm';
% norm(A - Hvm)