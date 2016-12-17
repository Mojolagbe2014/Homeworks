%% QRAlgorithm.m
%    Implements QR algorithm for obtaining eigenvalues of a matrix 
%       using implemented Modified Gram-Schimdt for QR decomposition
%        
%       Course:     ECE 7650
%       Homework:   1
%       Sub. Date:  October 26, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

clear; clc; close all;

%% set parameters
n = 5;                                      % matrix dimension
k = 30;                                     % number of iterations

%% create matrix A
A = vander(1:n);                         
A_copy = A;                                 % keep a copy of a for comparism

%% implement QR algorithm 
for loop = 1:k
    [Q, R] = modifiedGS(A);
    A = Q'*A*Q;
end

%% obtain the eigenvalues which are the diagonal entries of resulting A
for j = 1:n
    eigenvals(j, 1) = A(j,j);
end

%% output the results
disp('Eigenvalues from QR Algorithm:');
eigenvals

disp(' ')
disp('Eigenvalues from matlab built-in routine:');
eigenvalues = eig(A_copy)