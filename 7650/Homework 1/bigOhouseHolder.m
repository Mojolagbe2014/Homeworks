%% bigOhouseHolder.m
%    Shows the big "O" complexity of Householder Reflection Algorithm
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

%% set input variable n 
nmax = 200;                             % maximum input n 
nmin = 1;                               % minimum input n
narr = nmin:nmax;                       % set up input array for plotting

%% calculate f(n) and cg(n)
for n = nmin:nmax
    f(n) = 4*(n.^3) + 11*(n.^2) + 12*(n) + 3;
    cg(n) = 30*(n.^3);
end


%% output results
plot(narr, f(nmin:nmax), narr, cg(nmin:nmax))
title('Big "O" complexity of Householder Algorithm');
xlabel('Input (n)');
ylabel('Householder function');
legend('f(n)', 'cg(n)');