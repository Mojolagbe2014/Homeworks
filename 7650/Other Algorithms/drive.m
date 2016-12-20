clear; clc;
load('data/S.mat');
load('data/RHS.mat');

%% set parameters 
A = S;
b = RHS;
x0 = ones(length(b), 1);
maxItr = 40;
tol = 1e-6;
m = 20;
decType = 1;


%% solve the system of equation
% [x, itr, itri, err, H, v] = gmresrestart(A, x0, b, m, maxItr, tol, decType);
% [x, itr, err, v] = lanczosfom(A, x0, b, m, tol);
% [x, itr, err, H, v] = gmresrm(A, x0, b, m, maxItr, tol, decType);
% [x, H, v] = gmres(A, x0, b, m, decType);
% [x, itr2, err, H, v] = fomrestart(A, x0, b, m, maxItr, tol);
% [x, H, v, j] = fomrest(A, x0, b, m, tol);
% [x, H, v] = fom(A, x0, b, m)        ;
% [x, itr, err] = sd(A, b, x0, maxItr, tol);
% [x, itr, err] = rnsd(A, b, x0, maxItr, tol);              % convergence is extremely slow
% [x, itr, err] = minres(A, b, x0, maxItr, tol);


% tol = 1e-12;
% n = 100;                                                                                                                                                           
% A = randn(n, n);                                                                                                                                     
% A = 0.5*(A+A');                                                                                                                                                     
% A = A + n*eye(n);                                                                                                                                               
% b = randn(n, 1);                                                                                                                                                   
% m = 100;                                                                                                                                                              
% r = b;                                                                                                                                                               
% beta = norm(r);                                                                                                                                                      
% x0 = r./beta;           
% [x, itr, itri, err, H, v] = gmresrestart(A, x0, b, m, maxItr, tol, decType);
x1 = A\b;
abs(x1 - x)
% [H, v] = arnoldi(A, x0, m);                                                                                                                                          
% % x1 = A\b;                                                                                                                                            
% % abs(x1 - x)                                                                                                                                         
% Hm = H(1:m,1:m);                                                                                                                                                   
% Vm = v(:,1:m);                                                                                                                                                     
% Hvm = Vm*Hm*Vm';                                                                                                                                                   
% norm(A - Hvm)      
% 
% Vm*Vm'
% [U,R] = householder(A)