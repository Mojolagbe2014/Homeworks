%% laplacianNumeric.m
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

omega = 1;                          % over-relaxation constant / acceleration factor
omega_count = 1;                    % iteration counter for storing omega values 
omega_array = omega : 0.01: 1.9;    % array of relaxation factors to be used for ploting

for omega = omega : 0.01 : 1.9           % loop through the solver using different omega values
    max_iter = 1000;     % maximum iterations 
    epsolon = 1e-6;      % ralative displacement norm

    width = 1;      % width of the rectangle
    height = 1;     % height of the rectangle
    h = 0.1;        % grid Resolution 

    % set boundary condition voltages for the rectangle
    a = 0;        % left 
    b = 0;        % top 
    c = 100;        % right
    d = 0;        % bottom 

    %% calculate number of grid point and set the grid

    nx = (width/h) + 1;         % number of points in x direction
    ny = (height/h) + 1;        % number of points in y direction

    phi = zeros(nx, ny);    % grid/solution matrix phi(x,y) %% ones(nx-1, ny-1);


    %% set boundary condition (Dirichlet B. C)

    % non-corner elemets at the boundary
    phi(:,1) = a;        % bottom
    phi(:,ny) = c;     % top
    phi(1,:) = b;        % left
    phi(nx,:)= d;      % right

    % corner elements at the boundary
    phi(1, 1) = (a+b)/2;
    phi(nx, 1) = (a+d)/2;
    phi(nx, ny) = (c+d)/2;
    phi(1, ny) = (b+c)/2;


    %% initial guess for the grid matrix, set initial value to 1.0 for non-boundary elements
    for i = 2:1:nx-1
        for j = 2:1:ny-1
            phi(i, j) = 1.0;
        end
    end

    % phi(2 : nx - 2, 2 : ny - 2) = 1.0;

    %% solve the grid matrix with SOR
    iter = 1;           % counter for the number iterations
    err_norm = 99999;   % error norm for stoping the iterations

    while(iter < max_iter && err_norm > epsolon)
        ph =  0;        % solution norm
        disp_norm = 0;  % displacement norm

        % loop over inner matrix
        for i = 2:1:nx-1
            for j = 2:1:ny-1
                residual =  (phi(i - 1, j) +  phi(i + 1, j) +  phi(i, j - 1) + phi(i, j + 1)) ./ 4;
                acc_residual = omega * (residual - phi(i, j));
                phi(i, j) = phi(i, j) + acc_residual;

                ph = abs(ph) + abs(phi(i, j));                          % calculate current solution norm
                disp_norm = abs(disp_norm) + abs(acc_residual);         % calculate displacement norm
            end
        end

        % calculate relative displacement norm
        err_norm = disp_norm / ph;
        %increment the counter
        iter = iter + 1;
    end
    
    iter_array(omega_count) = iter;                  % store the number of iterations for each omega value
    omega_count = omega_count + 1;                % increment the omega loop counter
end


%% calculate the total flux emanating from the region
% flux = 0;       % initialize total flux to zero
% for i = 2:1:nx-2
%     flux = flux + phi(1, i) + phi(i, 1) + phi(nx - 1, i) + phi(i, ny - 1);      % outside potential
%     flux = flux - phi(2, i) - phi(i, 2) - phi(nx - 1, i) - phi(i, ny - 1);      % inside potential
% end

os = sum(phi(1, :)) + sum(phi(nx, :)) + sum(phi(:, 1)) + sum(phi(:, ny));                           % outside potential
oc = sum(phi(1, 1)) + sum(phi(1, ny)) + sum(phi(nx, 1)) + sum(phi(nx, ny));                         % outside corner

is = sum(phi(2, 2:ny-1)) + sum(phi(nx-1, 2:ny-1)) + sum(phi(2:nx-1, 2)) + sum(phi(2:nx-1, ny-1));   % inside potential
ic = sum(phi(2, 2)) + sum(phi(2, ny-1)) + sum(phi(nx-1, 2)) + sum(phi(nx-1, ny-1));                 % inside corner

flux = os - oc - ic - is;                                                                           % total flux


%% find the index of optimum over-relaxation constant

indexmin = find(min(iter_array) == iter_array);     % find the minimum number of iteration       
omega_min = omega_array(indexmin);                  % get minimum over-relaxation value
itera_min = iter_array(indexmin);                   % get minimum number of iterations


%% output the result
disp(['Total flux: ', num2str(abs(flux))]);
disp(' ');
disp(['Optimum over-relaxation constant: ', num2str(omega_min), ...
    ' [No of iterations: ', num2str(itera_min), ']']);
    
% plot the relaxation factor againt number of iterations
% subplot(2, 2, 1);
plot(omega_array, iter_array, 'b');
title('The graph of over-relaxation factor (\omega) against number of iterations (k)');
xlabel('Over-relaxation factor (\omega)');
ylabel('Number of iterations (k)');
grid on

% plot potential distribution with contour 
xv = 0:10:100;
yv = 0:10:100;
% subplot(2, 2, 2);
figure
contour(xv,yv,phi,'ShowText','on');
title('Potential Distribution (Contour)');
xlabel('V (volts)');
ylabel('V (volts)');
grid on

% subplot(2, 2, 3);
figure
grad = gradient(phi);
mesh(xv,yv,phi,grad);
title('Potential Distribution (Mesh)');
xlabel('V (volts)');
ylabel('V (volts)');
zlabel('V (volts)');


