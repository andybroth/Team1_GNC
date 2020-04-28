function h = getAngMom2d(r,v)
% Purpose:
%   Compute angular momentum (scalar value) for a planar motion. 
% Input:
% - r (2,N)
% - v (2,N)
% Output:
% - h (1,N)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h = r(1,:).*v(2,:)-r(2,:).*v(1,:);

end