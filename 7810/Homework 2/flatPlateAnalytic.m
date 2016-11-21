
clear; clc; close all;
sides = [101 104 103 102];
V1 = 100; 
width = 1;
height = 1;
maxIter = 150;

MeshData = GmshReadM('mesh_files/flat_plate.msh');          % Use GmshreadM to read the Gmsh mesh file
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