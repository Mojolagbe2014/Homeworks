%% Q1c.m
%   Solves the resulting matrix of 1 D poisson's equation
%
%       Problem: 1D Poisson's Equation
%       Method:  Numerical Solutions
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
h = 0.25;                                                                   % grid resolution 

%% Boundary condition (A) that is, Dirichlet B.C
A = [-2 1 0; 1 -2 1; 0 1 -2];                                               % resulting matrix
b = [-h.^2; -h.^2; -h.^2];                                                  % RHS
phi = A\b;                                                                  % solve the resulting system using backslash operator


%% Boundary Condition (B), that is Robin B.C; Nuemmann on U(0) and Dirichlet on U(1)
A = [-2 2 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -2];                               % resulting matrix
b = [-h.^2; -h.^2; -h.^2; -h.^2];                                           % RHS
Phi = A\b;                                                                  % solve the resulting system using backslash operator


%% output results 
disp('Results for Boundary Conditions (A)');
phi'
disp(' ');
disp('Results for Boundary Conditions (B)');
Phi'