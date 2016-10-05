%% laplacianNumeric.m
%   Calculate solve for the scalar potential,phi(x,y) 
%    using solveSOR function
%       
%       Approach: Numerical Solution
%        
%       Course:     ECE 7810
%       Homework:   1
%       Sub. Date:  October 4, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

clear; clc; close all;

%% solve with SOR
[phi, iter, nx, ny] = solveSOR(1, 1, 0.1, 0, 100, 0, 0, 1, 1.5, 1e-6, 100);


%% calculate the total flux emanating from the region
flux = 0;       % initialize total flux to zero
for i = 2:1:nx-1
    flux = flux + phi(1, i) + phi(i, 1) + phi(nx, i) + phi(i, ny);          % outside potential
    flux = flux - phi(2, i) - phi(i, 2) - phi(nx-1, i) - phi(i, ny-1);      % inside potential
end

%% output the result
disp(['Total flux: ', num2str(flux)]);
                                                                      

