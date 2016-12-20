%% Q4ii.m
%    Demonstrates Lanczos orthogonalization for symmetric/Hermitian
%       has an improved performance over Arnoldi's method 
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
% dim = [10 20 100 400 600 1000];
dim = [10];
m = 5;
useRandm = false;
showProofs = true;
showMatrices = false;
pauseFor = 0;

for c = 1:length(dim)
    A = spd(dim(c));                                                        % generate random SPD matrix
    b = randn(length(A), 1);                                                % generate random vector b 
    if useRandm; m = dim(c) - floor(randi(dim(c), 1)/2);  end               % randomly set the number of basis to be generated usually <= dimension
    
    %% obtain timetaken for the two algorithm
    tic
    [H, v] = arnoldi(A, b, m);
    tarn(c) = toc;
    tic
    [H1, v1] = lanczos(A, b, m);
    tlan(c) = toc;


    %% output the results
    disp(' ');
    disp(['============= Timetaken to Generate Km  for A[',num2str(dim(c)),'x',num2str(dim(c)),'] when m = ',num2str(m),' ===============']);
    disp(['Arnoldi Process:        ', num2str(tarn(c))]);
    disp(['Lanczos Method:         ', num2str(tlan(c))]);
    
    if(showMatrices)
        disp(' ');
        disp('========= Arnoldi results =========');
        real_H = real(H)
        real_v = real(v)
        disp(' ');
        disp('++++++++++ Lanczos results +++++++++');
        real_H1 = real(H1)
        real_v1 = real(v1)
        pause(pauseFor);
    end
    
    %% proof that v1, v are orthogonal basis
    if showProofs;
        disp(' ');
        disp('*************** Proofs of Orthogonality of Resulting Bases ****************');
        disp(['Norm of Km from Arnoldi:                   ', num2str(norm(v))]);
        disp(['Norm of Km from Lanczos:                   ', num2str(norm(v1))]);
        disp(['Error: norm(Lanczos(Km) - Arnoldi(Km)):    ', num2str(norm(v1 - v))]);
        disp(['Error: norm(Lanczos(Hm) - Arnoldi(Hm)):    ', num2str(norm(H - H1))]);
        disp(['Inner Product (Arnoldi): <v(m), v(m)>:     ', num2str(dot(v(:,m),v(:, m)))]);
        disp(['Inner Product (Arnoldi): <v(m), v(m-1)>:   ', num2str(dot(v(:,m),v(:, m-1)))]);
        disp(['Inner Product (Arnoldi): <v(2), v(m)>:   ', num2str(dot(v(:,2),v(:, m)))]);
        disp(['Inner Product (Lanczos): <v(m), v(m)>:     ', num2str(dot(v1(:,m),v1(:, m)))]);
        disp(['Inner Product (Lanczos): <v1(m), v1(m-1)>: ', num2str(dot(v1(:,m),v1(:, m-1)))]);
        disp(['Inner Product (Lanczos): <v1(2), v1(m)>: ', num2str(dot(v1(:,2),v1(:, m)))]);
    end
    disp('=============================================================================== ');
    disp(' ');
end