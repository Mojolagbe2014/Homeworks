%% laplacianNumberOfIterVsDispNorm.m
%   Calculate solve for the scalar potential,phi(x,y) 
%    on a rectangular grid using Successive Over-Relaxation (SOR).
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

%%  set variables
epsolon_count = 1;                    % iteration counter for storing omega values 
epsolon = 1e-2;

while epsolon > 1e-10           % loop through the solver using different omega values
    %% solve with SOR
    [phi, iter, nx, ny] = solveSOR(1, 1, 0.1, 0, 0, 100, 0, 1, 1.54, epsolon, 100);
    
    epsolon_array(epsolon_count) = epsolon;
    epsolon = epsolon/10;
    iter_array(epsolon_count) = iter;                  % store the number of iterations for each omega value
    epsolon_count = epsolon_count + 1;                % increment the omega loop counter
end


%% output the result

% plot the number of iteration againt relative displacement norm
semilogx(epsolon_array), semilogy(iter_array);
title('The graph of number of iterations (k) againt relative displacement norm');
xlabel('Relative Displacement Norm');
ylabel('Number of iterations (k)');
grid on
