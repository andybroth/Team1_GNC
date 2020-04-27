function [vals,indices] = min_n(x,n)
% Purpose:
%   This function returns the first n minimum number of elements in the 1D
%   vector x.
%
% Input:
% - x:  vector (1xN) or (Nx1)
% - n:  number of minimum values requested. (1x1)
% 
% Output:
% - vals:       minimum values in ascending order (1xn) or (nx1)
% - indices:    indices corresponding to the minimum values (1xn) or (nx1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~, index_all] = sort(x);
indices = index_all(1:n);
vals = x(indices);

end

