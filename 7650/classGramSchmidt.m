function [q] = classGramSchmidt(varargin)
%% Orthonormalize vectors using 
%   Classical Gram-Schmidt Method
%       
%       Author: Jamiu Mojolagbe

    m = length(varargin);                       % number of vectors
    r(1, 1) = norm(varargin{1});                % length of the first vector
    assert(r(1, 1) ~= 0);                       % confirm the vectors are linearly independent
 
    q{1} = (varargin{1}) ./ r(1, 1);              % normalize the first vector

    % for the remaining vectors
    for j = 2:1:m
       q{j} =  varargin{j};                     % start with the current vector
       for i = 1:1:j-1                          % for each previously normalized vectors
           r(i, j) = dot(varargin{j}, q{j});    % compute projections on each orthonormal vector
           q{j} = q{j} - r(i, j)*q{i};          % make q(j) orthogonal to all previous q
       end
       r(j, j) = norm(q{j});
       assert(r(j, j) ~= 0);                    % assert that vectors are linearly independent
       q{j} = q{j} / r(j, j);                   % normalize the newest orthonormal vector
    end
end
