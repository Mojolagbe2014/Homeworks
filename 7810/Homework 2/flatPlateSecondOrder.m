%% flatPlateSecondOrder.m
%   Calculate and demonstrate potential distribution
%       on a flat plate with source of excitation.
%
%       Problem: Poisson's Equation on a Flat Plate
%       Method:  Numerical Solution (High Order)
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
MeshData = GmshReadM('mesh_files/flat_plate_0.2.msh');          % Use GmshreadM to read the Gmsh mesh file

%% solve the Poisson's problem in Second Order
[phi, MeshData] = solveSecondOrder(MeshData,V1, rhoType, epsilon, sides, 'data/Q.mat', 'data/R.mat', 'data/T.mat');

%% Plot the solution
figure(1)
subplot(1, 2, 1);
tri = delaunay(MeshData.xNodes,MeshData.yNodes);
tr = triangulation(tri,MeshData.xNodes,MeshData.yNodes,phi);
trisurf(tr);
zlabel('Potential (V)');
ylabel('y-axis');
xlabel('x-axis');

title('Potential Distribution Over Entire Domain');
view(2);
colorbar;
shading interp; 
hold
set(gcf,'render','zbuffer');

subplot(1, 2, 2)
trisurf(tr);
zlabel('Potential (V)');
ylabel('y-axis');
xlabel('x-axis');
title('Potential Distribution Over Entire Domain');
view(3);
colorbar;
shading interp; 
hold
set(gcf,'render','zbuffer');

figure(2)
pointsize = 20;
scatter3(MeshData.xNodes,MeshData.yNodes,phi,pointsize, 'filled');
title('Scatter Plot of Potential Distribution');

