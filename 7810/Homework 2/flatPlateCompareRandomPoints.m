%% flatPlateCompareRandomPoints.m
%   Demonstrate relative errors in potential distribution
%       on a flat plate comparing 1st and 2nd Order solutions to analytic ones 
%       by choosing random points on the flat plates.
%
%       Problem: Poisson's Equation on a Flat Plate
%       Method:  Analytic & Numerical Solutions (First and Second Order)
%        
%       Course:     ECE 7810
%       Homework:   2
%       Sub. Date:  November 3, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca
close all; clear; clc;

%% set parameters 
sides = [101 104 103 102];                                  % line physics for the domain (probe point comes last)
V1 = 100;                                                   % apply potential to the probe point
rhoType = 5;                                                % set the type of excitation used (1-5)
epsilon = 1.0;                                              % dielectric constant of the domain
width = 1;                                                  % width of the domain
height = 1;                                                 % height of the doamin
maxIter = 100;                                              % maximum iterations for analytic solution
MeshData = GmshReadM('mesh_files/flat_plate.msh');          % Use GmshreadM to read the Gmsh mesh file

%% solve the grid using  both first and second order
[phi] = solveAnalytic(width, height, MeshData,V1, maxIter, sides);
[phi1] = solveFirstOrder(MeshData,V1, rhoType, epsilon, sides);
[phi2, MeshData2] = solveSecondOrder(MeshData,V1, rhoType, epsilon, sides, 'data/Q.mat', 'data/R.mat', 'data/T.mat');

%% generate and select random points on the grid and calculate the corresponding potentials
rng(0,'twister');
xcoor(:, 1) = (width-0.2).*rand(100,1) + 0.2;
ycoor(:, 1) = (width-0.2).*rand(100,1) + 0.2;
listOfPts = [xcoor(:) ycoor(:)];
pts = length(listOfPts);
for c = 1:pts
    pt(1:2) = listOfPts(c, :);
    %% obtain element for the selected point 
    thisElement = getEleIndices(MeshData, pt);
    xp = pt(1);                                                                          % x coordinate of the point
    yp = pt(2);                                                                          % y coordinate of the point
    y = MeshData.yNodes;
    x = MeshData.xNodes;
    A = MeshData.TriangleArea(thisElement);

    
    %% get the first and second order nodes of the element of the selected point
    fOrderNodes = MeshData.EleMatrix(thisElement, 1:3);
    sOrderNodes = MeshData2.EleMatrix(thisElement, 1:6);


    %% determine the potential from first order element
    P1 = y(fOrderNodes(2)) - y(fOrderNodes(3));             % (y2 - y3)
    P2 = y(fOrderNodes(3)) - y(fOrderNodes(1));             % (y3 - y1)
    P3 = y(fOrderNodes(1)) - y(fOrderNodes(2));             % (y1 - y2)
    Q1 = x(fOrderNodes(3)) - x(fOrderNodes(2));             % (x3 - x2)
    Q2 = x(fOrderNodes(1)) - x(fOrderNodes(3));             % (x1 - x3)
    Q3 = x(fOrderNodes(2)) - x(fOrderNodes(1));             % (x2 - x1)
    denom = 2 * A;                                          % 2*Area of the triangle

    a1 = x(fOrderNodes(2))*y(fOrderNodes(3)) - x(fOrderNodes(3))*y(fOrderNodes(2));
    a2 = x(fOrderNodes(3))*y(fOrderNodes(1)) - x(fOrderNodes(1))*y(fOrderNodes(3));
    a3 = x(fOrderNodes(1))*y(fOrderNodes(2)) - x(fOrderNodes(2))*y(fOrderNodes(1));

    alpha = ((1/denom)*[a1 P1 Q1; a2 P2 Q2; a3 P3 Q3]*[1; xp; yp]);


    phiEle(c, 1) = phi1(fOrderNodes(1))*alpha(1) + phi1(fOrderNodes(2))*alpha(2) + phi1(fOrderNodes(3))*alpha(3);

    %% determine the potential from second order element
    alp1 = alpha(1);                                                   % calc. shape function 1
    alp2 = alpha(2);                                                   % calc. shape function 2
    alp3 = alpha(3);                                                   % calc. shape function 3

    alpha1 = alp1*((2*alp1)-1);  alpha2 = 4*alp1*alp2;  alpha3 = 4*alp1*alp3;
    alpha4 = alp2*((2*alp2)-1);  alpha5 = 4*alp2*alp3;  alpha6 = alp3*((2*alp3)-1);

    phiEle(c, 2) = phi2(sOrderNodes(1))*alpha1 + phi2(sOrderNodes(2))*alpha2 + phi2(sOrderNodes(3))*alpha3 ...
        + phi2(sOrderNodes(4))*alpha4  + phi2(sOrderNodes(5))*alpha5  + phi2(sOrderNodes(6))*alpha6;

    %% obtain the analytical solution for the same point
    sigma = 0;
    for m = 1:1:maxIter
        if mod(m, 2) == 1 
            sigma = sigma + (sin((m*pi*xp)./width) * sinh((m*pi*yp)./width)) ./ (m * sinh((m*pi*height)./width));
        end 
        sigma2 = 0;
        for n = 1:1:maxIter
            A = (1/(((m*pi/width).^2) + ((n*pi/height).^2))) *  (((((-1).^(m+n))*144*width*height)/(m*n*pi))*(1-(1/height)*(1-(-1).^n)));
            sigma2 = sigma2 + A*sin((n*pi*xp)/width)*sin((n*pi*yp)/height);
        end
    end
    phiEle(c, 3) = (((4 * V1)./pi) *  sigma) + sigma2;


    %% calculate the relative error in the first and second order solutions
    err(c, 1) = abs(phiEle(c, 3) - phiEle(c, 1))/abs(phiEle(c, 1));

    err2(c, 1) = abs(phiEle(c, 3) - phiEle(c, 2))/abs(phiEle(c, 2));
end


figure(1)
subplot(1, 3, 1)
plot(1:length(err), err);
title('Relative Errors in 1^{st} Order Solution');
ylabel('Errors in the Numerical Solution');
xlabel('Chosen Points');

subplot(1, 3, 2)
plot(1:length(err), err2);
title('Relative Errors in 2^{nd} Order Solution');
ylabel('Errors in the Numerical Solution');
xlabel('Chosen Points');

subplot(1, 3, 3)
plot(1:length(err), err, 1:length(err), err2);
title('Relative Errors in 1^{st} & 2^{nd} Order Solutions');
ylabel('Errors in the Numerical Solution');
xlabel('Chosen Points');
legend('Error in the 1^{st} Order Solutions', 'Error in the 2^{nd} Order Solutions');
