function quat_C_A = quatCombine(quat_C_B,quat_B_A)
% Purpose:
%   Compute combined rotation of two successive rotations. Assume scalar
%   last convention.
%
% Input:
% - quat_C_B:   quaternion rotation from B to C
% - quat_B_A:   quaternion rotation from A to B
%
% Output:
% - quat_C_A:   quaternion rotation from A to C
%
% Author:
%   Kai Matsuka
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

quat_C_A = quatMultiplyOTimes(quat_C_B,quat_B_A);

end