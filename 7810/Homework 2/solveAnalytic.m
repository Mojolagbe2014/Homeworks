function [phi] = solveAnalytic(width, height, MeshData,V1, maxIter, side)
%% solveAnalytic 
%   Computes scalar potential,phi(x,y) on a rectangular grid
%   using Analytical Solution (Poisson's Problem)
%
%       Parameters
%           width:   Width of the domain
%           height:  Height of the domain
%           h:       Grid resolution
%           a,b,c,d: Boundary voltages in B|L|T|R
%           V1:      Applied potential
%           max_iter:Maximum number of odds itmes to be added
%       
%       Returns
%           phi:    Matrix of potential distribution
%           nx:     Number of points in x direction
%           ny:     Number of points in y direction
%        
%       Course:     ECE 7810
%       Homework:   1
%       Sub. Date:  November 4, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca


    %% set parameters
    phi = zeros(MeshData.nNodes, 1);    
    constr = zeros(MeshData.nNodes,1);
    constr(MeshData.BdNodes) = 1;   
    x = MeshData.xNodes;                                        
    y = MeshData.yNodes;
    if mod(maxIter, 2) ~= 0; maxIter = maxIter - 1; end
 
    tmp = find((MeshData.LinePhysics == side(4)));
    probePoints = unique(MeshData.LineMatrix(tmp, :));           
    tmp = find((MeshData.LinePhysics == side(1)) | (MeshData.LinePhysics == side(2)) | (MeshData.LinePhysics == side(3)));
    groundPoints = unique(MeshData.LineMatrix(tmp, :));          


    %% set boundary condition (Dirichlet B. C)
    phi(probePoints) =  V1;                                  
    phi(groundPoints) = 0;  

    %% solve the grid matrix with analytic solution
    for ni = 1:MeshData.nNodes
        sigma = 0;
        for m = 1:1:maxIter
            if mod(m, 2) == 1 
                sigma = sigma + (sin((m*pi*x(ni))./width) * sinh((m*pi*y(ni))./width)) ./ (m * sinh((m*pi*height)./width));
            end 
            sigma2 = 0;
            for n = 1:1:maxIter
                A = (1/(((m*pi/width).^2) + ((n*pi/height).^2))) *  (((((-1).^(m+n))*144*width*height)/(m*n*pi))*(1-(1/height)*(1-(-1).^n)));
                sigma2 = sigma2 + A*sin((n*pi*x(ni))/width)*sin((n*pi*y(ni))/height);
            end
        end
        if constr(ni) ~= 1
            phi(ni) = (((4 * V1)./pi) *  sigma) + sigma2;
        end
    end
        
end