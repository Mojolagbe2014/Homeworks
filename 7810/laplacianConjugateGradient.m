%% laplacianConjugateGradient.m
%   Calculate solve for the scalar potential,phi(x,y) 
%    on a rectangular grid using CONJUGATE GRADIENT method.
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

%% compute sparse matrix
[phi, bi, nx, ny] = computeSparse(1,1,0.1,0,0,0,100,0);


%% solve the resulting sparse matrix with conjugate gradient
ph = cgs(phi, bi);


% fill the sparse matrix with the calculated potentials
ph = ph';         
ph = reshape(ph, nx, ny);
ph = ph';
% ph = vec2mat(phi, ny);


