clear;clc;
A = [1      0       1.765 -2.342
    3       1.25    0    -0.0143
    0       2       1     0.3400
    0     -0.0143   0     0.8381]

y = [0; 4.571; 10; 3.667];


b = A\y;

detA = det(A)

%% Elementary matrix operation
I = eye(4, 4)                      % create identity matrix
% det(I) 

% elementary row interchange
disp('elementary row interchange');
Eij = swapRows(I, 2, 3)             % Obtain elementary matrix by interchanging two rows of I
det(Eij);                           % interchanging rows multiply the determinant by -1
Aij = Eij*A                         % interchanges rows of A
detA = det(Aij)                     % det = - det(A)

% elementary row scaling
disp('elementary row scaling');
Ec = I;
Ec(3, 3) = Ec(3, 3) .* 4            % scale row of identity matrix by contant c = 4
Ac = Ec*A                           % multiply the scaled Identity matrix by A
detA = det(Ac)                      % the determinant of A is now times contant c

% elementary row addition
disp('elementary row addition');
Eac = I;
Eac(3, 2) = Eac(3, 2) + 4            % scale row of identity matrix by contant c = 4
% det(Eac)                           % the determinant remain unchange with row addition 
A
Acc = Eac * A
detA = det(Acc)                      % determinant of A remain unchange


%% Eigenvalues, Eigenvectors, Singular Matrices and Determinants

