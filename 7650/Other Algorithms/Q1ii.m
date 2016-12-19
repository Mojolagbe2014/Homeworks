%% Q1i.m
%    Demonstrates that Arnoldi Orthonormalizaition   
%      fixed the linearly dependency in the choice of V
%      such that V = [r; Ar; (A.^2)r... (A.^m-1)r] as basis for Km
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
dim = [10 20 50 100 200 300 400];
for c = 1:length(dim)
    A = randn(dim(c), dim(c));                                              % set matrix A 
    b = randn(length(A), 1);                                                % set vector b 
    m = dim(c) - floor(randi(dim(c), 1)/2);                                 % set the number of basis to be generated
    
    %% obtain the raw basis in the form V = [r; Ar; (A.^2)r... (A.^m-1)r]
    r = b;
    V(:,1) = r;
    for j = 1:m
        V(:,j+1) = (A.^j)*r;
    end

    %% obtain same basis from arnoldi
    [~, v] = arnoldi(A, b, m);


    %% display the results and show that for linearly independent bases
    disp(' ');
    disp([' ======= Results of dim[',num2str(dim(c)),'x',num2str(dim(c)),']  and m = ',num2str(m),'  ========= ']);
    disp(['Rank of in-appropriate V:        ', num2str(rank(V))]);
    disp(['Rank of V obtained from Arnoldi: ', num2str(rank(v))]);
    clear v V;
end