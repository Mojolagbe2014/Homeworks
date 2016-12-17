%% Q3.m
%    Demonstrates the following iterative techniques 
%       - Block Jacobi 
%       - Block Gauss-Seidel
%
%    With and without the following permutations
%       - RCM symmetric permutation 
%       - BFS permutation.  
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
bs = [200 500 1000 1500 2500 5000 10000];                                   % varing block sizes not neccesarily in ascending or descending order it can be random
sIdx = 5;                                                                   % number of block sizes to plot, in order of listing above
showPlot = true;                                                            % whether to show obtained solutions in graphs
graphPause = 10;                                                            % graph will pause for this duration in seconds
guess = 0;                                                                  % initial guess
maxIter = 1000;                                                             % maximum expected iterations
tol = 1e-6;                                                                 % relative error tolerance
nx = 100;                                                                   % correspond to matrix dimension 19600x19600
ny = 100;
xmin = 0;                                                                   
xmax = 1;
ymin = 0;
ymax = 1;
fontsize = 12;
dim = nx * ny;                                                              % dimension of A

%% set boundary conditions 
Tleft = 75;
Tright = 50;
Tbottom = 0;
Ttop = 100;

%% solve the Laplacian Problem and obtain A and RHS (b)
[A, b] = getSystemLaplaceSparse(nx,ny, xmin, xmax, ymin, ymax, Tleft, Tright, Tbottom, Ttop);

% obtain the permutations of A using BFS and RCM
[P, pi] = bfs(A, 1, true);                                                  % obtain BFS permutation of A
A_bfs = P*A*P';                                                             % Breadth First Search permuted A

[P, pi] = rcm(A, true);                                                     % obtain RCM Permutation
A_rcm = P*A*P';                                                             % Reverse Cuthill McKee permutted A

for i = 1:length(bs)
    blockSize = bs(i);
    
    %% solve the Ax = b using Block Iterative Techniques
    % block Jacobi without permutation
    [x1, iter_ju{i}, err_ju{i}] = blockJacobi(A, b, blockSize, guess, maxIter, tol);
    
    % block Gauss-Seidel without permutation
    [x2, iter_gu{i}, err_gu{i}] = blockGaussSeidel(A, b, blockSize, guess, maxIter, tol);
    
    % block Jacobi with BFS & RCM permutations
    [x3, iter_jb{i}, err_jb{i}] = blockJacobi(A_bfs, b, blockSize, guess, maxIter, tol);
    [x4, iter_jr{i}, err_jr{i}] = blockJacobi(A_rcm, b, blockSize, guess, maxIter, tol);
    
    % block Gauss-Seidel with BFS & RCM permutations
    [x5, iter_gb{i}, err_gb{i}] = blockGaussSeidel(A_bfs, b, blockSize, guess, maxIter, tol);
    [x6, iter_gr{i}, err_gr{i}] = blockGaussSeidel(A_rcm, b, blockSize, guess, maxIter, tol);
end

%% show the convergence plot
figure(1);
leg = {['Block Jacobi            - ', num2str(bs(1))], ['Block Gauss-Seidel - ', num2str(bs(1))]};
if sIdx > length(bs) || sIdx < 1; sIdx = length(bs); end
if sIdx == 1; semilogy(1:iter_ju{1}, err_ju{1},'LineWidth', 1.5); 
else semilogy(1:iter_ju{1}, err_ju{1}, '--','LineWidth', 1.5);
end
hold on
semilogy(1:iter_gu{1}, err_gu{1},'LineWidth', 1.5)
for i = 2:sIdx
    semilogy(1:iter_ju{i}, err_ju{i}, '--','LineWidth', 1.5)
    semilogy(1:iter_gu{i}, err_gu{i}, 'LineWidth', 1.5);
    leg = [leg ['Block Jacobi            - ', num2str(bs(i))], ['Block Gauss-Seidel - ', num2str(bs(i))]];
end
legend(leg);
title(['Convergence for ', num2str(dim),'x', num2str(dim), ' Matrix (Unpermuted)']);
xlabel('Iteration Count');
ylabel('||Ax - b||/||b||');
set(gca,'FontSize',fontsize);

figure(2);
leg = {['Block Jacobi (BFS)            - ', num2str(bs(1))], ['Block Gauss-Seidel (BFS) - ', num2str(bs(1))], ['Block Jacobi (RCM)            - ', num2str(bs(1))], ['Block Gauss-Seidel (RCM) - ', num2str(bs(1))]};
if sIdx == 1; semilogy(1:iter_jb{1}, err_jb{1}, 'LineWidth', 1.5); hold on; semilogy(1:iter_jr{1}, err_jr{1},'LineWidth', 1.5);
else semilogy(1:iter_jb{1}, err_jb{1}, '--','LineWidth', 1.5); hold on; semilogy(1:iter_jr{1}, err_jr{1}, '--','LineWidth', 1.5);
end

semilogy(1:iter_gb{1}, err_gb{1},'LineWidth', 1.5);
semilogy(1:iter_gr{1}, err_gr{1},'LineWidth', 1.5)
for i = 2:sIdx
    semilogy(1:iter_jb{i}, err_jb{i}, '--', 'LineWidth', 1.5)
    semilogy(1:iter_gb{i}, err_gb{i}, 'LineWidth', 1.5);
    semilogy(1:iter_jr{i}, err_jr{i}, '.-', 'LineWidth', 1.5)
    semilogy(1:iter_gr{i}, err_gr{i}, 'LineWidth', 1.5);
    leg = [leg ['Block Jacobi (BFS)            - ', num2str(bs(i))], ['Block Gauss-Seidel (BFS) - ', num2str(bs(i))] ['Block Jacobi (RCM)            - ', num2str(bs(i))], ['Block Gauss-Seidel (RCM) - ', num2str(bs(i))]];
end
legend(leg);
title(['Convergence for ', num2str(dim),'x', num2str(dim), ' Matrix (Permuted)']);
xlabel('Iteration Count');
ylabel('||Ax - b||/||b||');
set(gca,'FontSize',fontsize);
