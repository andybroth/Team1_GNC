function exp_v = quatExp(v)
% Purpose:
%   This function implements quaternion exponential. This function assumes
%   scalar last convention. Example use is
%       d_quat = quatExp(0.5*d_theta)
%   where
%       d_theta:    minimal representation of local attitude error (3x1) [rad]
%       d_quat:     corresponding quaternion
% 
% Input:
%   v:      vector (3xN)
% Output:
%   exp_v:  quaternion exponential (4xN)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vNorm = sqrt(v(1,:).^2+v(2,:).^2+v(3,:).^2);
sincNorm = sinc(vNorm);
exp_v = [sincNorm.*v(1,:);
         sincNorm.*v(2,:);
         sincNorm.*v(3,:);
         cos(vNorm)];

end

