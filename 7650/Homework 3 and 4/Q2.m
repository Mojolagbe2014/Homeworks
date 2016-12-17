%% Q2.m
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
nxy = [10; 20; 30; 40; 50; 60; 70; 80; 90; 100; 110; 120; 130; 140];        % corresponding to dimension [100 400 900 1600 2500 3600 4900 6400 8100 10000 12100 14400 16900 19600]
plotSolution = true;                                                        % whether to show obtained solutions in graphs
showTimeGraph = true;                                                       % whether to show the time taken graph for the 4 conditions checked
graphPause = 5;                                                             % graph will pause for this duration in seconds
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

for i = 1:length(nxy)
    nx = nxy(i);                               
    ny = nxy(i);
    dim(i) = nx * ny;
    %% solve the Laplacian Problem and obtain A and RHS (b)
    [A, b] = getSystemLaplaceSparse(nx,ny, xmin, xmax, ymin, ymax, Tleft, Tright, Tbottom, Ttop);


    %% solve the Ax = b using LU decomposition with and without permutation
    % Unpermuted A
    tic
    [L,U] = lu(A);
    solution1 = U\(L\b);
    t1(i) = toc;


    % Matlab permuted A
    tic
    [L,U,P,Q] = lu(A);
    solution2 = Q*(U\(L\(P*b)));
    t2(i) = toc;


    % Breadth First Search permuted A
    [P, pi] = bfs(A, 1, true);
    Ab = P*A*P';
    tic
    [L,U] = lu(Ab);
    solution3 = P'*(U\(L\(P*b)));
    t3(i) = toc;


    % Reverse Cuthill McKee permutted A
    [P, pi] = rcm(A, true);
    Ab = P*A*P';
    tic
    [L,U] = lu(Ab);
    solution4 = P'*(U\(L\(P*b)));
    t4(i) = toc;



    %% output the results
    disp(' ');
    disp(['================== Time taken for LU Solutions - Dim(', num2str(dim(i)), 'x',   num2str(dim(i)),') ============================']);
    disp(['No Permutation:                                ', num2str(t1(i))]);
    disp(['MATLAB Built-in Permutation:                   ', num2str(t2(i))]);
    disp(['Breadth First Search Permutation:              ', num2str(t3(i))]);
    disp(['Reverse Cuthill-McKee Permutation:             ', num2str(t4(i))]);
    
    if plotSolution
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, solution1, 1, 'No Permutation LU Solution');
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, solution2, 2, 'MATLAB Built-in Permutation LU Solution');
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, solution3, 3, 'Breadth First Search Permutation LU Solution');
        plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, solution4, 4, 'Reverse Cuthill-McKee Permutation LU Solution');
        pause(graphPause);
    end
end

%% show the time taken in a graph
if showTimeGraph && length(nxy) > 1;
    figure(10);
    plot(dim, t1, dim, t2, dim, t3, dim, t4);
    title('Time taken for LU solution of matrix A');
    xlabel('Input Matrix A^{n x n}');
    ylabel('Timetaken (s) ');
    legend('No Permutation', 'MATLAB Built-in Permutation', 'Breadth First Search Permutation', 'Reverse Cuthill-McKee Permutation');
end