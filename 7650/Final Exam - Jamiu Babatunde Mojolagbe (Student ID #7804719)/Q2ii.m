%% Q2i.m
%    Demonstrates that eigenvalues Hm = Hn are equal to the eigenvalues of A
%       where m = n for a real n x n matrix A
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

%% set parameters
dim = [10 20 50 100 200 300 400];
for c = 1:length(dim)
    A = randn(dim(c), dim(c));                                              % set matrix A 
    b = randn(length(A), 1);                                                % set vector b 
    m = dim(c) - floor(randi(dim(c), 1)/2);                                 % set the number of basis to be generated

    %% obtain Hm from Arnoldi process
    r = b;
    beta = norm(r);
    x0 = r./beta;
    [H, v] = arnoldi(A, x0, m);
    Hm = H(1:m,1:m);

    %% obtain the eigen value of A and eigen of Hm
    eA = eig(A);
    eHm = eig(Hm);


    %% output the results
    disp(' ');
    disp([' ======= Results of A[',num2str(dim(c)),'x',num2str(dim(c)),'] and m = ',num2str(m),'  ========= ']);
    disp(['Maximum Eigenvalue of A:        ', num2str(max(eA))]);
    disp(['Maximum Eigenvalue of Hm:       ', num2str(max(eHm))]);
    clear Hm Vm;
end

