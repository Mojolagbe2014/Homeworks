%% Q2visualize.m
%    Shows the time taken to solve an input matrix A with 
%       - Original unpermuted matrix
%       - BFS symmetric permutation
%       - RCM symmetric permutation 
%       - built-in MATLAB permutation.  
%        
%       Course:     ECE 7650
%       Homework:   3 & 4
%       Sub. Date:  December 5, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

close all; clear; clc;


%% set parameters
nx = 30;                               
ny = 30;
xmin = 0;
xmax = 1;
ymin = 0;
ymax = 1;
fontsize = 12;

%% set boundary conditions 
Tleft = 75;
Tright = 50;
Tbottom = 0;
Ttop = 100;

%% solve the Laplacian Problem and obtain A and RHS (b)
[A, b] = getSystemLaplaceSparse(nx,ny, xmin, xmax, ymin, ymax, Tleft, Tright, Tbottom, Ttop);
% load('data/S.mat');
% load('data/RHS.mat');
% A = S;
% b = RHS;

%% solve the Ax = b using LU decomposition with and without permutation
% Unpermuted A
[L,U] = lu(A);

% Matlab permuted A
[L2,U2,P,Q] = lu(A);

% Breadth First Search permuted A
[P, pi] = bfs(A, 111, true);
A3 = P*A*P';
[L3,U3] = lu(A3);

% Reverse Cuthill McKee permuted A
[P, pi] = rcm(A, true);
A4 = P*A*P';
[L4,U4] = lu(A4);


%% output the results
figure;
subplot(2, 2,  1)
spy(A);
title('Sparsity of A - Unpermuted','FontSize',fontsize);
set(gca,'FontSize',fontsize);

subplot(2, 2, 2)
spy(L);
title('Sparsity of L - Unpermuted','FontSize',fontsize);
set(gca,'FontSize',fontsize);

subplot(2, 2, 3)
spy(U);
title('Sparsity of U - Unpermuted','FontSize',fontsize);
set(gca,'FontSize',fontsize);

figure;
subplot(2, 2, 1)
spy(L2);
title('Sparsity of L  - MATLAB Permutation','FontSize',fontsize);
set(gca,'FontSize',fontsize);

subplot(2, 2, 2)
spy(U2);
title('Sparsity of U  - MATLAB Permutation','FontSize',fontsize);
set(gca,'FontSize',fontsize);

figure;
subplot(2, 2,  1)
spy(A3);
title('Sparsity of A - BFS Permutation','FontSize',fontsize);
set(gca,'FontSize',fontsize);

subplot(2, 2,  2)
spy(L3);
title('Sparsity of L - BFS Permutation','FontSize',fontsize);
set(gca,'FontSize',fontsize);

subplot(2, 2, 3)
spy(U3);
title('Sparsity of U - BFS Permutation','FontSize',fontsize);
set(gca,'FontSize',fontsize);

figure;
subplot(2, 2, 1)
spy(A4);
title('Sparsity of A - RCM Permutation','FontSize',fontsize);
set(gca,'FontSize',fontsize);

subplot(2, 2, 2)
spy(L4);
title('Sparsity of L - RCM Permutation','FontSize',fontsize);
set(gca,'FontSize',fontsize);

subplot(2, 2, 3)
spy(U4);
title('Sparsity of U - RCM Permutation','FontSize',fontsize);
set(gca,'FontSize',fontsize);