%% matlabQR_vs_myQR.m
%    Tests the built-in MATLAB QR decomposition performance 
%       against my implemented Modified Gram-Schmidt QR Decomposition
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
n = [10, 100, 1000, 2000, 3000];                    % set various dimensions as a row vector
[n_siz, n_size] = size(n);                          % get the number of total elements in the n vector

for j = 1:n_size
    A = exp(i * pi * randn(n(j), n(j)));            % create complex matrix nxn
    
    
%% decompose matrix A
    tic
    [q, r] = qr(A);                                 % decompose matrix A using built-in matlab routine
    tar(j) = toc                                   % store the timetaken in a row vector (tar) for each dimensional loop of A
    clear q r;                                      % free up the space used for next function
    tic
    [q, r] = modifiedGS(A);                         % decompose matrix A using modified Gram-Schmidt method
    tarr(j) = toc                                   % store the timetaken in a row vector (tarr) for each dimensional loop of A
end

%% output the results
plot(n, tar, n, tarr)
title('Computational Time ');
xlabel('Input Matrix A^{n x n}');
ylabel('Timetaken (s) ');
legend('Matlab built-in QR', 'Implemented Modified Gram-Schmidt');