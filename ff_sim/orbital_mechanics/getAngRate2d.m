function angRate = getAngRate2d(p,v)
% Purpose:
%   Compute angular rate (scalar value) for a planar motion. 
% Input:
% - r (2,N)
% - v (2,N)
% Output:
% - angRate (1,N)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h0 = getAngMom2d(p,v);
pnormSqr = p(1,:).^2+p(2,:).^2;
angRate = h0/pnormSqr;

end

