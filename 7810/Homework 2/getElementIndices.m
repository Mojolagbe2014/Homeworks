function [elementID, localID] = getElementIndices(nelematrix, node)
%% getElementIndices  
%   Get the list of elements that has node "node"
%
%       Course:     ECE 7810
%       Homework:   2
%       Sub. Date:  November 3, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

    [elementID, localID] = find(nelematrix == node);
end

