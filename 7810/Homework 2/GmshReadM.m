function MeshData = GmshReadM(file_name)
%% GmshRead
%   [MeshData] = GmshRead(DomainData)
%
%   This function reads GMSH mesh file with extension '*.msh', and saves
%   this results in a data structure MeshData
%   
%   The mesh file must be created as a version 2 GMSH file excluding
%   elements with no physical number assigned for them.
% 
%   Also, this function only supports the mesh having only line elements on
%   the boundary.
%
%   MeshData is divided into:
%           - .nNodes        : Number of Nodes in mesh
%           - .BdNodes       : Boundary Nodes of mesh
%           - .xNodes        : x-coordinates of Nodes
%           - .yNodes        : y-coordinates of Nodes
%           - .NodesID       : I.D. of the Nodes
%           - .nLineElements : Number of line segments on the boundary
%           - .LineMatrix    : nLineElements-by-2 matrix contains the
%                              nodes of each line segment element.
%           - .SegMidpoint   : x- and y-coordinates of the line segments
%                              midpoint
%           - .SegLength     : Length of Line Segments
%           - .SegNormal     : Normal Unit Vector to the line segment.
%           - .ElementsID    : ID of Elements according to GMSH File
%           - .nElements     : Number of Elements
%           - .EleMatrix     : nElements-by-3 matrix contains the nodes of
%                              each triangular element
%           - .PhysNumber    : Physics Number of elements. Can be used to
%                                  represent dielectric numbers.
%           - .RxPoints      : Nodes in the mesh where receiver points are
%                              located.
%           - .xCentroids    : x-coordinate of centroids of each triangular
%                              element in the mesh
%           - .yCentroids    : y-coordinate of centroids of each triangular
%                              element in the mesh
%           - .TriangleArea  : Area of each triangular element in the mesh
%
%   Created by: Amer Zakaria for Prof. Joe LoVetri Research Group
%               University of Manitoba, Winnipeg, Canada.
%
%   $Revision: 7.0 $  $Date: 2009/06/01 01:12 p.m. $

%% Function Starts
% Read the number of nodes in the mesh
nNodes = dlmread(file_name, ' ',[4 0 4 0]');

% Read the NodesID and the coordinates of the nodes

tmpData = dlmread(file_name, ' ',[5 0 (nNodes+4) 3]);

NodesID = tmpData(:,1);
xNodes  = tmpData(:,2);
yNodes  = tmpData(:,3);

% Read the number of elements in the mesh

nElements = dlmread(file_name, ' ',[(nNodes+7) 0 (nNodes+7) 0]);

% Read all the elements (line + triangular)

tmpData = dlmread(file_name,' ',[(nNodes+8) 0 (nElements + nNodes+7) 7]);

% Separating line elements from triangular elements

% Line elements has a GMSH ID of (1)
itemp = find(tmpData(:,2) == 1);
LineElements = tmpData(itemp,:);
nLineElements = length (itemp); 

LineMatrix = [LineElements(:,6) LineElements(:,7)];
LineNodes = [tmpData(itemp,6);tmpData(itemp,7)];
LinePhysics = LineElements(:,4);

BdNodes = unique(LineNodes);

% Triangular elements has a GMSH ID of (2)
itemp = find(tmpData(:,2) == 2);
TriElements = tmpData(itemp,:);
nElements = length(itemp);

ElementsID      = TriElements(:,1);
EleMatrix  = [TriElements(:,6) TriElements(:,7) TriElements(:,8)];
PhysNumber = TriElements(:,4);

% Calculate the Centroids of Different Triangular Elements
xCentroids = (xNodes(EleMatrix(:,1)) + xNodes(EleMatrix(:,2)) + xNodes(EleMatrix(:,3)))/3;
yCentroids = (yNodes(EleMatrix(:,1)) + yNodes(EleMatrix(:,2)) + yNodes(EleMatrix(:,3)))/3;

% Calculate the Area of Different Triangular Elements
ii = EleMatrix(:,1);
jj = EleMatrix(:,2);
kk = EleMatrix(:,3);
TriangleArea = abs(( (xNodes(jj)-xNodes(ii)).*(yNodes(kk)-yNodes(ii)) - (xNodes(kk)-xNodes(ii)).*(yNodes(jj)-yNodes(ii)))./ 2.0);

% Calculating the Area of each Triangular Element

TriangleVector1 = [(xNodes(EleMatrix(:,2)) - xNodes(EleMatrix(:,1)))';(yNodes(EleMatrix(:,2)) - yNodes(EleMatrix(:,1)))'];
TriangleVector2 = [(xNodes(EleMatrix(:,3)) - xNodes(EleMatrix(:,1)))';(yNodes(EleMatrix(:,3)) - yNodes(EleMatrix(:,1)))'];
TriangleNormals = (TriangleVector1(1,:).*TriangleVector2(2,:) - TriangleVector2(1,:).*TriangleVector1(2,:))';

if any(TriangleNormals < 0)
    error('For some triangular elements, the nodes are numbered in clockwise manner! Fix Mesh. Program Terminated.');
end

% % % MeshData
MeshData.nNodes = nNodes;
MeshData.BdNodes  = BdNodes;
MeshData.xNodes = xNodes;
MeshData.yNodes = yNodes;
MeshData.NodesID = NodesID;
MeshData.nLineElements = nLineElements;
MeshData.LineMatrix = LineMatrix;
MeshData.LinePhysics = LinePhysics;
MeshData.nElements = nElements;
MeshData.ElementsID = ElementsID;
MeshData.EleMatrix = EleMatrix;
MeshData.PhysNumber = PhysNumber;
MeshData.xCentroids = xCentroids;
MeshData.yCentroids = yCentroids;
MeshData.TriangleArea = TriangleArea;
% Function Ends