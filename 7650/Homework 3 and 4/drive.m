
clear; close all; clc;
blockSize = 1000;       % 1000; 2000
plotSolution = false;                                                        % whether to show obtained solutions in graphs
graphPause = 5;                                                             % graph will pause for this duration in seconds
guess = 0;                                                                  % initial guess
maxIter = 1000;                                                            % maximum expected iterations
tol = 1e-6;                                                                % relative error tolerance
nx = 50;                                                                   % correspond to matrix dimension 19600x19600
ny = 50;
xmin = 0;                                                                   
xmax = 1;
ymin = 0;
ymax = 1;
fontsize = 13;
dim = nx * ny;       
Tleft = 75;
Tright = 50;
Tbottom = 0;
Ttop = 100;

[A, b] = getSystemLaplaceSparse(nx,ny, xmin, xmax, ymin, ymax, Tleft, Tright, Tbottom, Ttop);
[P, pi] = bfs(A, 1, true);                                                  % obtain BFS permutation of A
A_bfs = P*A*P';                                                             % Breadth First Search permuted A

[P, pi] = rcm(A, true);                                                     % obtain RCM Permutation
A_rcm = P*A*P';    

[x1, iter_ju, err_ju] = blockJacobi(A, b, blockSize, guess, maxIter, tol);
[x2, iter_gu, err_gu] = blockGaussSeidel(A, b, blockSize, guess, maxIter, tol);
% block Jacobi with BFS & RCM permutations
[x3, iter_jb, err_jb] = blockJacobi(A_bfs, b, blockSize, guess, maxIter, tol);
[x4, iter_jr, err_jr] = blockJacobi(A_rcm, b, blockSize, guess, maxIter, tol);

% block Gauss-Seidel with BFS & RCM permutations
[x5, iter_gb, err_gb] = blockGaussSeidel(A_bfs, b, blockSize, guess, maxIter, tol);
[x6, iter_gr, err_gr] = blockGaussSeidel(A_rcm, b, blockSize, guess, maxIter, tol);

semilogy(1:iter_ju, err_ju,'LineWidth', 1.5)
hold on
semilogy(1:iter_gu, err_gu, 'LineWidth', 1.5);
hold off
title('Convergence Without Permutation');
xlabel('Iteration Count');
ylabel('||Ax - b||/||b||');
legend('Jacobi', 'Gauss-Seidel');
set(gca,'FontSize',fontsize);

figure;
semilogy(1:iter_jb, err_jb, 'LineWidth', 1.5)
hold on
semilogy(1:iter_jr, err_jr, 'LineWidth', 1.5)
semilogy(1:iter_gb, err_gb, 'LineWidth', 1.5)
semilogy(1:iter_gr, err_gr, 'LineWidth', 1.5)
hold off
title('Convergence With Permutation');
xlabel('Iteration Count');
ylabel('||Ax - b||/||b||');
legend('Jacobi with BFS', 'Jacobi with RCM', 'Gauss-Seidel with BFS', 'Gauss-Seidel with RCM');
set(gca,'FontSize',fontsize);