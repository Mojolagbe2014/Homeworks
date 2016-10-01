function [phi, nx, ny] = solveAnalytic(width, height, h, a, b, c, d, V0, max_iter)
%% solveAnalytic 
%   Computes scalar potential,phi(x,y) on a rectangular grid
%   using Analytical Solution.
%
%       Parameters
%           width:   Width of the domain
%           height:  Height of the domain
%           h:       Grid resolution
%           a,b,c,d: Boundary voltages in B|L|T|R
%           V0:      Applied potential
%           max_iter:Maximum number of odds itmes to be added
%       
%       Returns
%           phi:    Matrix of potential distribution
%           nx:     Number of points in x direction
%           ny:     Number of points in y direction
%        
%       Course:     ECE 7810
%       Homework:   1
%       Sub. Date:  October 4, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca


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


    %% solve the grid matrix with analytic solution

    for i = 1:1:nx-1
        for j = 1:1:ny-1
            sigma = 0;
            for n = 1:2:max_iter
                sigma = sigma + (sin((n*pi*h*i)./width) * sinh((n*pi*h*j)./width)) ./ (n * sinh((n*pi*height)./width));
            end
            if i+1~=1 && j+1~=1 && i+1~= nx && j+1~=ny
                phi(i+1, j+1) =  ((4 * V0)./pi) *  sigma; 
            end
        end
    end
end