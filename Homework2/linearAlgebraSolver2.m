% linearAlgebraSolver.m
%   Solves system of linear equations 
%       of the format Ax = b
%       where:
%           A is the co-efficient matrix
%           b is the vector containing the right sides of equations
%           x are the unkowns inform of column vector 
%
%        Using solve() function
%
%               Author: Jamiu Mojolagbe

clc; 
clear; 
clf;


%% set variables
syms x y z
eqn1 = -x	+ 5*y		+ z 	== 12;
eqn2 = 0*x 	-  y 	+ 5*z	== 13;
eqn3 = 5*x 	 -  y 		+ 0*z 	== 3;

%% convert equations to system of linear equations in the form Ax = b
[A,B] = equationsToMatrix([eqn1, eqn2, eqn3], [x, y, z])


%% use solve to solve Ax = b for the vector of unknowns x
sol = solve([eqn1, eqn2, eqn3], [x, y, z]);
xSol = sol.x
ySol = sol.y
zSol = sol.z


%% calculate the condition number of the matrix
condNum = cond(A);                         % cond(A) returns the 2-norm condition number of matrix A.
% cond(A, 1)                      % cond(A,P) returns the P-norm condition number of matrix A
conditionNumber = vpa(cond(A), 30)       % using vpa to obtain 30-digit accuracy
condN1 = vpa(cond(A, 1), 30);
condNf = vpa(cond(A, 'fro'), 30); % returns the Frobenius norm condition number using vpa to obtain 30-digit accuracy
condNi = vpa(cond(A, inf), 30);   % returns the infinity norm condition number using vpa to obtain 30-digit accuracy

%% calculate the determinant of A
determinant = det(A)
