function R = euler_rotation(seq,angles)
% Purpose:
%   This function computes Euler angles given the Euler sequence (e.g.
%   3-1-3) and corresponding angles.
%
% Input:
% - seq:        Euler sequence (1x3) or (3x1)
% - angles:     Euler angles [rad] (1x3) or (3x1)
%
% Output:
% - R:          Rotation matrix (3x3)
%
% Author: Kai Matsuka
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


R1 = principal_rotation(seq(1),angles(1));
R2 = principal_rotation(seq(2),angles(2));
R3 = principal_rotation(seq(3),angles(3));

R = R3*R2*R1;

end