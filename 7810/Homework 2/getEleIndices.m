function [RxTriIndex] = getEleIndices(MeshData, points)

% CalculateMs
%   Ms = CalculateMs(DomainData)
%
%   This functions builds the connectivity matrix used to evaluate the
%   field values at given receiver locations.
%
%   Note: At the moment, this matrix assumes the receiver locations is the
%         same despite the transitter location. This function is
%         independent on the type of boundary.
%
%   Input: 
%   -----------------------------------------------------------------------
%   
%   MeshData : The struct returned from ReadGmshTA.m
%   points   : List of xy-coords of points to locate, given in column order.
%
%   Output:
%   -----------------------------------------------------------------------
%
%   RxTriIndex : List of element indices of the elements that contain the
%                   the given points.
%
%   Created by: Amer Zakaria for Prof. Joe LoVetri Research Group
%               University of Manitoba, Winnipeg, Canada.
%
%   $Revision: 1.0b $  $Date: 2009/08/12 01:08 p.m. $
%   $Modification: 2.0  $  $Date: October 26, 2010. $ (Gabriel Faucher)
% 

%% Function Starts

%setup point location
RxPositions = points;
[nRx, temp] = size(points);
RxTriIndex  = zeros(nRx,1);

% Find the location of the receiver points in the triangular mesh
xMN = MeshData.xNodes;
yMN = MeshData.yNodes;
A = [xMN(MeshData.EleMatrix(:,1)) yMN(MeshData.EleMatrix(:,1))]';
B = [xMN(MeshData.EleMatrix(:,2)) yMN(MeshData.EleMatrix(:,2))]';
C = [xMN(MeshData.EleMatrix(:,3)) yMN(MeshData.EleMatrix(:,3))]';

for iRx = 1:nRx
    
    P = [RxPositions(iRx,1)*ones(1,MeshData.nElements) ; RxPositions(iRx,2)*ones(1,MeshData.nElements)];
    v0 = C - A;
    v1 = B - A;
    v2 = P - A;
      
    dot00 = dot(v0,v0);
    dot01 = dot(v0,v1);
    dot02 = dot(v0,v2);
    dot11 = dot(v1,v1);
    dot12 = dot(v1,v2);
        
    invDenom = 1 ./ (dot00 .* dot11 - dot01 .* dot01);
    a = (dot11 .* dot02 - dot01 .* dot12) .* invDenom;
    b = (dot00 .* dot12 - dot01 .* dot02) .* invDenom;
    apb = a + b;
        
    distCent = sqrt((MeshData.xCentroids - RxPositions(iRx,1)).^2 + (MeshData.yCentroids -  RxPositions(iRx,2)).^2);
    [vmin imin] = min(distCent);
    
    itemp = find(a > 0 & b > 0 & apb < 1);
    if isempty(itemp)
        RxTriIndex(iRx)= imin;
    else
       RxTriIndex(iRx) = itemp(1);
    end
        
end

