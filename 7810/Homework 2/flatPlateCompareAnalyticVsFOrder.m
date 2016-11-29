%% flatPlateCompareAnalyticVsFOrder.m
%   Demonstrate relative errors in potential distribution
%       on a flat plate comparing results of 1st Order and Analytic Solutions.
%
%       Problem: Poisson's Equation on a Flat Plate
%       Method:  Analytic & Numerical Solutions (First Order)
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
[phi] = solveAnalytic(width, height, MeshData,V1, maxIter, sides);                                                      % obtain the analytic solution
[phi1] = solveFirstOrder(MeshData,V1, rhoType, epsilon, sides); 

%% calculate the relative errors for both the 1st and 2nd order solutions
err = abs(phi - phi1);
for i = 1:length(err)
    if err(i) ~= 0; err(i) = err(i)/abs(phi1(i)); end
end

%% output the results
figure(1)
subplot(1, 2, 1)
trisurf(MeshData.EleMatrix,MeshData.xNodes,MeshData.yNodes,err)
zlabel('Potential (V)');
ylabel('y-axis');
xlabel('x-axis');
title('Error Over the Entire Domain in 1^{st} Order Solution');
view(3);
colorbar;
shading interp; 
hold
set(gcf,'render','zbuffer');

subplot(1, 2, 2)
plot(1:length(err), err);
title('Relative Errors in 1^{st} Order Solution Against Nodes');
ylabel('Errors in the Numerical Solution');
xlabel('Node Numbers');

