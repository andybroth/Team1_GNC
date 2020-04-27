function quat_corr = quatShortest(quat)
% Purpose:
%   Ensure that quaternion represents shortest rotation
%
% Input:
% - quat:       original quaternion (scalar last) (4x1)
%
% Output:
% - quat_corr:  corrected quaternion (scalar last) (4x1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if quat(4) < 0
    quat_corr = -quat;
else
    quat_corr = quat;
end


end


