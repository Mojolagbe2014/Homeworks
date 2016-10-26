function [q, r] = modifiedGS(A)
%% modifiedGS.m Orthonormalize vectors using 
%   Modified Gram-Schmidt Method
%   
%   Input: A (a matrix)
%   Returns: q, r (q is a set of orthonormal vectors and r is upper
%            triangular mtrix)
%       
%       Author: Jamiu Mojolagbe

    m = length(A);                          % number of vectors
    r(1, 1) = norm(A(:,1));                 % length of the first vector
    assert(r(1, 1) ~= 0);                   % confirm the vectors are linearly independent
 
    q(:,1) = (A(:,1)) ./ r(1, 1);           % normalize the first vector

    % for the remaining vectors
    for j = 2:1:m
       q(:,j) =  A(:,j);                     % start with the current vector
       for i = 1:1:j-1                       % for each previously normalized vectors
           r(i, j) = dot(q(:,j), q(:,i));    % compute projections on each orthonormal vector
           q(:,j) = q(:,j) - r(i, j)*q(:,i); % make q(j) orthogonal to all previous q
       end
       r(j, j) = norm(q(:,j));
       assert(r(j, j) ~= 0);                 % assert that vectors are linearly independent
       q(:,j) = q(:,j) / r(j, j);            % normalize the newest orthonormal vector
    end
end