function [elementID, localID] = getElementIndices(MeshData, node)
%% getElementIndices  
%   Get the list of elements that has node "node"

    [elementID, localID] = find(MeshData.EleMatrix == node);
end

