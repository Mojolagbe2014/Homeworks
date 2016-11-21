%% flatPlateAnalytic.m
%   Calculate and demonstrate potential distribution
%       on a flat plate with source of excitation.
%
%       Problem: Poisson's Equation on a Flat Plate
%       Method:  Analytical Solution
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
width = 1;                                                  % width of the domain
height = 1;                                                 % height of the doamin
maxIter = 100;                                              % maximum iterations for analytic solution
MeshData = GmshReadM('mesh_files/flat_plate.msh');          % Use GmshreadM to read the Gmsh mesh file

%% solve the Poisson's problem with analytical solution
[phi] = solveAnalytic(width, height, MeshData,V1, maxIter, sides);

%% Plot the solution
figure(1)
trisurf(MeshData.EleMatrix,MeshData.xNodes,MeshData.yNodes,phi)
zlabel('Potential (V)');
ylabel('y-axis');
xlabel('x-axis');
view(2);
colorbar;
shading interp; 
hold
set(gcf,'render','zbuffer');