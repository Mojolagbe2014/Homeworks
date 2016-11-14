function [elementID, localID] = getElementIndices(nelematrix, node)
%% getElementIndices  
%   Get the list of elements that has node "node"

    [elementID, localID] = find(nelematrix == node);
end

