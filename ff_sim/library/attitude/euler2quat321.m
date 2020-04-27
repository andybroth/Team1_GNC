function [q] = euler2quat321(euler)
% Purpose:
%   This function computes DCM from Euler angles, assuming 3-2-1 Euler
%   sequence.
%
% Input:
% - euler:  euler angles that rotates a vector in frame N to B in 3-2-1
%           sequence. [rad] (3x1)
%                   euler = [alpha beta gamma]' (yaw-pitch-roll)
%           and
%                   R = Rx(gamma)*Ry(beta)*Rz(alpha)
%
% Output:
% - q:      quaternion that transforms a vector from N to B frame. Scalar
%           last.
%            
%
% Author:   Kai Matsuka
% Date:     07/26/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = euler2dcm321(euler);
q = dcm2quat(R);

end