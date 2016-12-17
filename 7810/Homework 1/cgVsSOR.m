%% cgVsSOR.m
%   Determines the computational efficiency  
%    of conjugate gradient method against SOR
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

%% set parameters
V0 = 100;           % applied potential
h = 0.01;            % grid resolution/discretization
omega = 1.54;       % over relaxation constant
width = 1;          % grid width
height = 1;         % grid height
eps = 1e-6;         % relative displacement norm (for SOR technique only)
guess = 1;          % initial guess (for SOR technique technique only)
max_iter = 100;     % maximum number of iterations (for SOR technique technique only)
rhs = 0;            % the right handside of the laplacian problem (for sparse matrix technique technique only)

%% solve with SOR
tic
[phi_sor, iter, nx_sor, ny_sor] = solveSOR(width, height, h, 0, V0, 0, 0, guess, omega, eps, max_iter);
toc


%% compute sparse matrix
[phi, bi, nx, ny] = computeSparse(width,height,h,0,0,V0,0,0);
phi = sparse(phi);
tic
%% solve the resulting sparse matrix with conjugate gradient
ph = cgs(phi, bi);
toc

% % fill the sparse matrix with the calculated potentials
% ph = ph';         
% ph = reshape(ph, nx, ny);
% ph = ph';
% % ph = vec2mat(phi, ny);

%% output the results
% execution time (in seconds) for various levels of discretizations
% h_arr = [0.01, 0.02, 0.025, 0.05, 0.1, 0.2, 0.25];                                  % resolution
% sor_arr = [0.052283, 0.016308, 0.008184, 0.002619, 0.000962, 0.000841, 0.000360];   % sor time
% cg =   [2.391753, 0.142630, 0.065373, 0.003437, 0.002277, 0.001398, 0.001268];     % cg time without sparse matrix generation time

% figure
% plot (h_arr,sor_arr, '-r', h_arr,cg, '-b');
% title('The graph of grid resolution against both SOR and sparse techniques');
% xlabel('Grid resolution (h)');
% ylabel('Timetaken in second, t(s)');
% legend('SOR', 'Sparse Matrix');
