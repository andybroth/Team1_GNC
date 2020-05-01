function [R] = euler2dcm321(euler)
% Purpose:
%   This function computes DCM from Euler angles, assuming 3-2-1 Euler
%   sequence.
%
% Input:
% - euler:  euler angles that rotates a vector in frame N to B in 3-2-1
%           sequence. [rad] (3x1)
%                   euler = [alpha beta gamma]'
%           and
%                   R = Rx(gamma)*Ry(beta)*Rz(alpha)
%
% Output:
% - R:      DCM from frame N to B
%            
%
% Author:   Kai Matsuka
% Date:     01/31/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Rz = principalRotation(3,euler(1));
Ry = principalRotation(2,euler(2));
Rx = principalRotation(1,euler(3));

R = Rx*Ry*Rz;

end