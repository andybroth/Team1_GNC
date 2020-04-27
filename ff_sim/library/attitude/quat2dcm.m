function R = quat2dcm(q)
% Purpose:
%   Computes direction cosine matrix from quaternion
% 
% Input:
% - q:      quaternion that transforms a vector from N to B frame. Scalar
%           last.
%
% Output:
% - R:      direction consine matrix that transforms a vector expressed in
%           N to the same vector expressed in B frame. That is
%                   v_B = R*v_N
% 
% Author:   Kai Matsuka
% Ref: 
%   [1] Markley, F. Landis, and John L. Crassidis. Fundamentals of
%       spacecraft attitude determination and control. Vol. 33. New York:
%       Springer, 2014.  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s = q(4);
v = [q(1);q(2);q(3)];
skewv = skew(v);
R = s^2*eye(3)-2*s*skewv+skewv*skewv+v*v';

end