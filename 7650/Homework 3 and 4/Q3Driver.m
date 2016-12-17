%% Q3.m
%    Demonstrates the following iterative techniques works
%       - Block Jacobi 
%       - Block Gauss-Seidel
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
bs = [100 200 500 1000 1600];
plotSolution = true;                                                        % whether to show obtained solutions in graphs
graphPause = 15;                                                             % graph will pause for this duration in seconds
guess = 0;                                                                  % initial guess
maxIter = 2000;                                                             % maximum expected iterations
tol = 1e-8;                                                                 % relative error tolerance
nx = 50;                                                                    % correspond to matrix dimension 19600x19600
ny = 50;
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
[L,U] = lu(A);
solution = U\(L\b);

for i = 1:length(bs)
    blockSize = bs(i);
    
    %% solve the Ax = b using Block Iterative Techniques
    % block Jacobi without permutation
    [x1, iter_ju, err_ju] = blockJacobi(A, b, blockSize, guess, maxIter, tol);
    
    % block Gauss-Seidel without permutation
    [x2, iter_gu, err_gu] = blockGaussSeidel(A, b, blockSize, guess, maxIter, tol);

    %% output the results
    disp(' ');
    disp(['================== Error and Iteration Count - Block Size (', num2str(blockSize),') ============================']);
    disp(['Block Jacobi:              Relative Error <<  ', num2str(err_ju(iter_ju)), ' @ ', num2str(iter_ju), ' iterations']);
    disp(['Block Gauss-Seidel:        Relative Error <<  ', num2str(err_gu(iter_gu)), ' @ ', num2str(iter_gu), ' iterations']);
    
    if plotSolution
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, solution, 1, 'Regular LU Solution');
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, x1(:, iter_ju+1), 2, ['Block Jacobi Solution - Block Size (', num2str(blockSize),')']);
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, x2(:, iter_gu+1), 3, ['Block Gauss-Seidel Solution- Block Size (', num2str(blockSize),')']);
        pause(graphPause);
    end
end