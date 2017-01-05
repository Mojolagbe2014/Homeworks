%% Q1d.m
%   Compare exact solution with the numerical solution
%
%       Problem: 1D Poisson's Equation 
%       Method:  Analytic & Numerical Solutions
%        
%       Course:     ECE 7810 Final Exam
%       Sub. Date:  January 6, 2017
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca
close all; clear; clc;

%% set parameters
h = 0.25;

%% Boundary condition (A) that is, Dirichlet B.C
% numerical parameters  
A = [-2 1 0; 1 -2 1; 0 1 -2];
b = [-h.^2; -h.^2; -h.^2];
phi_n = A\b;                                                                % solve the resulting system 

% analytical parameters
internalPts = h*[1 2 3];                                                               
% obtain analytical solution for the points
for i = 1:length(internalPts)
    x = internalPts(i);
    phi_e(i) = (-x.^2)/2   + 0.5*x;                                         % exact solution
end

%% Boundary Condition (B), that is Robin B.C; Nuemmann on U(0) and Dirichlet on U(1)
% numerical parameters  
A = [-2 2 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -2];                               % resulting matrix
b = [-h.^2; -h.^2; -h.^2; -h.^2];                                           % RHS
Phi_n = A\b;                                                                  % solve the resulting system 

% analytical parameters
internalPts = h*[0 1 2 3];                                                               
% obtain analytical solution for the points
for i = 1:length(internalPts)
    x = internalPts(i);
    Phi_e(i) = (-x.^2)/2   + 0.5;                                         % exact solution
end