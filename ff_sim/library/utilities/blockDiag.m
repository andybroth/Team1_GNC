function A = blockDiag(A_block,N)
% Purpose:
%   This function takes mxn matrix and creates a block diagonal matrix of
%   size NxN blocks, which has size mNxnN overall.
%
% Input:
% - A_block:    a mxn matrix, which constitutes one block
% - N:          number of blocks to be included in A
% Output:
% - A:          block diagonal matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m = size(A_block,1);
n = size(A_block,2);

A = zeros(m*N,n*N);

for ii = 1:N
    A(m*(ii-1)+1:m*ii,n*(ii-1)+1:n*ii) = A_block;
end

end



