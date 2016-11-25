%% FlatPlateFirstOrder.m
%   Calculate and demonstrate potential distribution
%       on a flat plate with source of excitation.
%
%       Problem: Poisson's Equation on a Flat Plate
%       Method:  Numerical Solution (First Order)
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
epsilon = 1.5;                                              % dielectric constant of the domain
MeshData = GmshReadM('mesh_files/flat_plate.msh');          % Use GmshreadM to read the Gmsh mesh file

%% solve the Poisson's problem in First Order
[phi] = solveFirstOrder(MeshData,V1, rhoType, epsilon, sides);

%% Plot the solution
figure(1)
% trisurf(MeshData.EleMatrix,MeshData.xNodes,MeshData.yNodes,phi)
tri = delaunay(MeshData.xNodes,MeshData.yNodes);
tr = triangulation(tri,MeshData.xNodes,MeshData.yNodes,phi);
trisurf(tr)
zlabel('Potential (V)');
ylabel('y-axis');
xlabel('x-axis');
view(2);
colorbar;
shading interp; 
hold
set(gcf,'render','zbuffer');