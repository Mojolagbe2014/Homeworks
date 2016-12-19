function A = spd(n)
%% spd
%   Generate Hermitian/symmetric positive definite matrix
%       Input:   n - dimension of the resulting matrix
%       Returns: A - resulting hermitian positive definite matrix
%       Author: Jamiu Mojolagbe

    %% obtain SPD matrix
    A = exp(1i * pi * randn(n, n));         % generate a random n x n matrix
    A = 0.5*(A+A');
    A = A + n*eye(n);
end