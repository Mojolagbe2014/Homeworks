%% Q4i.m
%    Demonstrates when A is symmetric, the matrix Hm is symmetric tridiagonal 
%       (symmetric and its non zero entries are limited to the main,
%       first-upper, and first-lower diagonals) 
%        
%       Course:     ECE 7650
%       Homework:   Final Exam
%       Sub. Date:  December 18, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

close all; clear; clc;

%%  set parameters
dim = 10;                                                                   % set dimensional of A
m = 6;                                                                     % set the size of Krylov subspace
b = randn(dim, 1);                                                          % obtain random rhs
A = spd(dim);                                                                 % generate random symmetric positive definite matrix

%% orthogonalize A with arnoldi process and obtain Hm
[H, ~] = arnoldi(A, b, m);


%% output the result
disp(' ');
disp(' ========= Showing Tridiagonal Hm ========== ');
real(H(1:m, 1:m)) 