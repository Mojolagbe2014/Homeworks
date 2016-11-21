%% sphericalDomain.m
%   Calculate and demonstrate potential distribution
%       on a spherical plate with source of excitation.
%
%       Problem: Poisson's Equation on a Spherical Plate
%       Method:  Numerical Solution
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
sides = [101 104 103 102];
V1 = 100; 
rhoType = 5;
epsilon = 1.5;
MeshData = GmshReadM('mesh_files/sphere.msh');          % Use GmshreadM to read the Gmsh mesh file

%% solve the Poisson's problem in First Order
[phi] = solveFirstOrder(MeshData,V1, rhoType, epsilon, sides);


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