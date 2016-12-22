%% drive.m
%    Demonstrates Adaptive Cross Approximation Algorithm
%       as an efficient alternative to truncated SVD 
%        
%       Course:     ECE 7650
%       Homework:   Final Exam
%       Sub. Date:  December 18, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca
%


close all; clear; clc;

%% set parameters
dim = [100 300 500 700 1000];
for i = 1:length(dim)
    % dim = 1000;                                                                 % dimension of the input matrix
    k = 20;                                                                    % desired rank of input matrix
    tol = 1e-8;                                                                % error tol for the approximation
    [A] = createRankDefMatrix(dim(i), k);                                      % create rank deficient matrix A

    %% obtain the approximants via the two variants of ACA and Truncated SVD
    tic
    [~, u, v] = aca(A, tol);
    taca(i) = toc;

    tic
    [~, u2, v2] = aca2(A, tol);
    taca2(i) = toc;

    tic
    % truncated SVD begins
    [U,S,V] = svd(A);

    singular_values = diag(S);
    Sprime = singular_values(singular_values > tol*singular_values(1));   % check the error  
    ksvd = length(Sprime);
    % svd_error = singular_values(min(dim,ksvd+1));
    Sprime = diag(Sprime);
    Uprime = U(:,1:ksvd);
    Vprime = V(:,1:ksvd);
    Uprime = Uprime*Sprime;
    %truncated SVD ends
    tsvd(i) = toc;

    Aaca = u*v;
    Aaca2 = u2*v2;
    Asvd = Uprime*Vprime';
    
    errAca(i) = norm(A - Aaca);
    errAca2(i) = norm(A - Aaca2);
    errSvd(i) = norm(A - Asvd);

    %% output the results
    disp(' ');
    disp(['============= Proofs   rank = ',num2str(k),' and tol = ',num2str(tol),' ===============']);
    disp(['Norm(A - Aaca):                            ', num2str(errAca(i))]);
    disp(['Norm(A - Aaca2):                           ', num2str(errAca2(i))]);
    disp(['Norm(A - Asvd):                            ', num2str(errSvd(i))]);
    disp(' ');
    disp(['Time (ACA):                                 ', num2str(taca(i))]);
    disp(['Time (ACA2):                                ', num2str(taca2(i))]);
    disp(['Time (SVD):                                 ', num2str(tsvd(i))]);
end



%% plot the overall time complexity
figure;
plot(dim, taca, '-b', dim, taca2, '--r', dim, tsvd);
title(['Time Complexity ACA versus Truncated SVD for rank = ',num2str(k),' and tol = ',num2str(tol)]);
xlabel('Matrix Dimension A^{nxn}');
ylabel('Timetaken (s)');
legend('ACA', 'ACA 2', 'Truncated SVD');

figure;
plot(dim, taca, '-b', dim, taca2, '--r');
title(['Time Complexity ACA versus ACA2 for rank = ',num2str(k),' and tol = ',num2str(tol)]);
xlabel('Matrix Dimension A^{nxn}');
ylabel('Timetaken (s)');
legend('ACA', 'ACA 2');