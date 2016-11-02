%% numberOfIterVsDispNorm.m
%   Plot number of iterations against different value of displacement norm
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
epsolon = 1e-2;     % relative displacement norm
V0 = 100;           % applied potential
h = 0.01;            % grid resolution/discretization
omega = 1.54;       % over relaxation constant
width = 1;          % grid width
height = 1;         % grid height
guess = 1;          % initial guess 
max_iter = 10000;     % maximum number of iteration

while epsolon > 1e-11           % loop through the solver using different omega values
    %% solve with SOR
    [phi, iter, nx, ny] = solveSOR(width, height, h, 0, 0, V0, 0, guess, omega, epsolon, max_iter);
    
    epsolon_array(epsolon_count) = epsolon;
    epsolon = epsolon/10;                             % decrement relative displacement norm
    iter_array(epsolon_count) = iter;                 % store the number of iterations for each omega value
    epsolon_count = epsolon_count + 1;                % increment the omega loop counter
end


%% output the result

% plot the number of iteration againt relative displacement norm
semilogx(epsolon_array), semilogy(iter_array);
title('The graph of number of iterations (k) againt relative displacement norm');
xlabel('Relative Displacement Norm in order of 1exp(-x)');
ylabel('Number of iterations (k)');
grid on
