% simple function to convert points (x,y) to matrix indices (row,col)
% inputs: x -vector of x-coordinates of points
%         y -vector of y-coordinates of points
%         h -space between discrete points.  assumed to be same for both x
%           and y directions
%         num -number of rows of square matrix that is to contain the given
%              points.
% returns: row -row index of point in matrix
%          col -column index of point in matrix

function [row col] = pointMap(x,y,h,num)

row = num - int16(y / h);
col = int16(x / h) + 1;

row = uint16(row);
col = uint16(col);