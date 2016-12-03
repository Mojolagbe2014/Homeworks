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
bs = [10; 20; 30; 40; 50; 100; 200; 300; 400; 500; 600; 700; 800; 900; 1000; 1100; 1200; 1300; 1400; 1500];        
plotSolution = false;                                                        % whether to show obtained solutions in graphs
graphPause = 5;                                                             % graph will pause for this duration in seconds
guess = 0;                                                                  % initial guess
maxIter = 10000;                                                            % maximum expected iterations
tol = 1e-10;                                                                % relative error tolerance
nx = 140;                                                                   % correspond to matrix dimension 19600x19600
ny = 140;
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

%% obtain the permutations of A using BFS and RCM
[P, pi] = bfs(A, 1, true);                                                  % obtain BFS permutation of A
A_bfs = P*A*P';                                                             % Breadth First Search permuted A

[P, pi] = rcm(A, true);                                                     % obtain RCM Permutation
A_rcm = P*A*P';                                                             % Reverse Cuthill McKee permutted A

for i = 1:length(bs)
    blockSize = bs(i);
    
    %% solve the Ax = b using Block Iterative Techniques
    % block Jacobi without permutation
    [x1, iter_ju(i), err_ju(i)] = blockJacobi(A, b, blockSize, guess, maxIter, tol);
    
    % block Gauss-Seidel without permutation
    [x2, iter_gu(i), err_gu(i)] = blockGaussSeidel(A, b, blockSize, guess, maxIter, tol);
    
    % block Jacobi with BFS & RCM permutations
    [x3, iter_jb(i), err_jb(i)] = blockJacobi(A_bfs, b, blockSize, guess, maxIter, tol);
    [x4, iter_jr(i), err_jr(i)] = blockJacobi(A_rcm, b, blockSize, guess, maxIter, tol);
    
    % block Gauss-Seidel with BFS & RCM permutations
    [x5, iter_gb(i), err_gb(i)] = blockGaussSeidel(A_bfs, b, blockSize, guess, maxIter, tol);
    [x6, iter_gr(i), err_gr(i)] = blockGaussSeidel(A_rcm, b, blockSize, guess, maxIter, tol);


    %% output the results
    disp(' ');
    disp(['================== Error and Iteration Count - Block Size (', num2str(blockSize),') ============================']);
    disp(['Unpermuted Block Jacobi:              Relative Error <<  ', num2str(err_ju(i)), ' Iteration << ', num2str(iter_ju(i)) ]);
    disp(['Unpermuted Block Gauss-Seidel:        Relative Error <<  ', num2str(err_gu(i)), ' Iteration << ', num2str(iter_gu(i)) ]);
    disp(['BFS Permuted Block Jacobi:            Relative Error <<  ', num2str(err_jb(i)), ' Iteration << ', num2str(iter_jb(i)) ]);
    disp(['RCM Permuted Block Jacobi:            Relative Error <<  ', num2str(err_jr(i)), ' Iteration << ', num2str(iter_jr(i)) ]);
    disp(['BFS Permuted Block Gauss-Seidel:      Relative Error <<  ', num2str(err_gb(i)), ' Iteration << ', num2str(iter_gb(i)) ]);
    disp(['RCM Permuted Block Gauss-Seidel:      Relative Error <<  ', num2str(err_gr(i)), ' Iteration << ', num2str(iter_gr(i)) ]);
    
    if plotSolution
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, x1, 1, 'No Permutation Block Jacobi Solution');
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, x2, 2, 'No Permutation Block Gauss-Seidel Solution');
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, x3, 3, 'Permuted Jacobi with BFS');
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, x4, 4, 'Permuted Jacobi with RCM');
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, x5, 5, 'Permuted Gauss-Seidel with BFS');
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, x6, 6, 'Permuted Gauss-Seidel with RCM');
        pause(graphPause);
    end
end

%% show the convergence
figure(10);
plot(iter_ju, err_ju, iter_gu, err_gu);
title('Convergence for ', num2str(dim), 'x', num2str(dim), ' Without Permutation');
xlabel('Iteration Count');
ylabel('||Ax - b||/||b||');
legend('Block Jacobi', 'Block Gauss-Seidel');

figure(11);
plot(iter_jb, err_jb, iter_jr, err_jr, iter_gb, err_gb, iter_gr, err_gr);
title('Convergence for ', num2str(dim), 'x', num2str(dim), ' With Permutations');
xlabel('Iteration Count');
ylabel('||Ax - b||/||b||');
legend('Block Jacobi with BFS', 'Block Jacobi with RCM', 'Block Gauss-Seidel with BFS', 'Block Gauss-Seidel with RCM');
