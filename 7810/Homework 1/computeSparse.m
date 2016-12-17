function [phi, bi, nx, ny] = computeSparse(xLength, yLength, hxy, a, b, c, d, rhs)
%% computeSparse 
%   Computes banded sparse matrix of Laplacian problem
%   using five point stencil.
%
%       Parameters
%           xLength: Width of the domain
%           yLength: Height of the domain
%           hxy:     Grid resolution
%           a,b,c,d: Boundary voltages in B|L|T|R
%           rhs:     Right hand side of the problem
%       
%       Returns
%           phi:    Matrix of potential distribution
%           bi:     Resulting RHS 
%           nx:     Number of lines on x-axis
%           ny:     Number of lines on y-axis
%        
%       Course:     ECE 7810
%       Homework:   1
%       Sub. Date:  October 4, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

    %% calculate and set needed parameters 
    nx = (xLength / hxy) - 1;           % Number of lines on x-axis
    ny = (yLength / hxy) - 1;           % Number of lines on y-axis

    iNodes = nx * ny;                   % Total nodes which is = total number of equations and unknowns
    currX = 0; currY = 0;               % Initialize current x-axis line and y-axis line to first line

    phi = zeros(iNodes, iNodes);        % phi nodes of unknowns
    bi = zeros(iNodes,1);               % initialize rhs


    %% sparse matrix generator core
    for j = 1:1:iNodes;
        if currY >= 1; currY = ceil(j / nx); 
        else currY = 1;end

        currX = j; 
        while currX > nx ; currX = currX - nx; end

        bi(j) = rhs * hxy * hxy;

        for i = 1:1:iNodes
            if (currY == 1 && currY ~= ny) 
                if (currX == 1 && currX ~= nx) 
                    if i == j;   bi(j) = bi(j) - (b + c); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j + 1) || (i == j + nx); phi(j, i) = 1; 
                    else phi(j, i) = 0; 
                    end

                elseif currX ~= 1 && currX ~= nx
                    if (i == j); bi(j) = bi(j) - c; end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j - 1) || (i ==  j + 1) || (i ==  j + nx); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                elseif (currX ~= 1 && currX == nx) 
                    if (i == j); bi(j) = bi(j) - (c + d); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j - 1) || (i ==  j + nx); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                elseif (currX == 1 && currX == nx) 
                    if (i == j); bi(j) = bi(j) - (b + c + d); end
                    if i == j; phi(j, i) = -4;
                    elseif (i ==  j + nx); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                end
    %             end
            elseif (currY ~= 1 && currY == ny)
                if (currX == 1 && currX ~= nx) 
                    if (i == j); bi(j) = bi(j) - (b + a); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j + 1) || (i == j - nx); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                elseif (currX ~= 1 && currX ~= nx)
                    if (i == j); bi(j) = bi(j) - (a); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j - 1) || (i == j + 1) || (i == j - nx); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                elseif (currX ~= 1 && currX == nx) 
                    if (i == j); bi(j) = bi(j) - (a + d); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j - 1) || (i == j - nx); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                elseif (currX == 1 && currX == nx) 
                    if (i == j); bi(j) = bi(j) - (a + b + d); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j - nx); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end
                end

    %             end

            elseif (currY ~= 1 && currY ~= ny) 
                if (currX == 1 && currX ~= nx) 
                    if (i == j); bi(j) = bi(j) - (b); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j + 1) || (i == j + nx) || (i == j - nx); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                elseif (currX ~= 1 && currX ~= nx) 
                    if i == j; phi(j, i) = -4;
                    elseif (i == j + 1) || (i == j - 1) || (i == j + nx) || (i == j - nx); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                elseif (currX ~= 1 && currX == nx)
                    if (i == j); bi(j) = bi(j) - (d); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j - 1) || (i == j + nx) || (i == j - nx); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                elseif (currX == 1 && currX == nx) 
                    if (i == j); bi(j) = bi(j) - (b + d); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j - 1) || (i == j + nx) || (i == j - nx); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end
                end

    %             end

            elseif (currY == 1 && currY == ny)
                if (currX == 1 && currX ~= nx)
                    if (i == j); bi(j) = bi(j) - (a + b + c); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j + 1); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                elseif (currX ~= 1 && currX ~= nx) 
                    if (i == j); bi(j) = bi(j) - (a + c); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j + 1) || (i == j - 1); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                elseif (currX ~= 1 && currX == nx) 
                    if (i == j); bi(j) = bi(j) - (a + c + d); end
                    if i == j; phi(j, i) = -4;
                    elseif (i == j - 1); phi(j, i) = 1;
                    else phi(j, i) = 0;
                    end

                elseif (currX == 1 && currX == nx) 
                    if (i == j); bi(j) = bi(j) - (a + b + c + d); end
                    if i == j; phi(j, i) = -4;
                    else phi(j, i) = 0;
                    end
                end

            end

        end	
    end
end

