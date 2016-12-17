function [x] = solveCG(A, x, b, curr_iter, max_iter, r, p, q, betta)
%% solveCG 
%   Solves linear algebra, Ax = b, 
%   using Conjugate Gradient (CG) Method.
%
%       Parameters
%           width:   Width of the domain
%           height:  Height of the domain
%           h:       Grid resolution
%           a,b,c,d: Boundary voltages in B|L|T|R
%           guess:   Initial guess
%           omega:   Over-relaxation constant / acceleration factor (this value is not used)
%           epsolon: Relative displacement norm
%           max_iter: Maximum number of iterations expected
%       
%       Returns
%           phi:    Matrix of potential distribution
%           nx:     Number of points in x direction
%           iter:   Number of iterations
%           ny:     Number of points in y direction
%        
%       Course:     ECE 7810
%       Homework:   1
%       Sub. Date:  October 4, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca
% [x] = solveCG(A, x, b, curr_iter, max_iter)
    
    if curr_iter == 1; r = b - (A*x); p = r(:); q = A*r; 
    else p = r + betta .* p; q = A*r(:) + betta .* q; end
    alpha = (abs(r).*abs(r)) ./ dot(p, q);
    x = x + alpha .* p;
    prev_r = r;
    r = prev_r  - alpha.*q;
    betta = (abs(r).*abs(r))./ (abs(prev_r).*abs(prev_r));
    p = r + betta .* p; 
    q = A*r + betta.*q;
    curr_iter = curr_iter + 1;
    
    if (curr_iter <= max_iter); solveCG(A, x, b, curr_iter, max_iter, r, p, q, betta); end
end