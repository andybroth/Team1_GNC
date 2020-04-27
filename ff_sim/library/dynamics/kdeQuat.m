function qdot = kdeQuat(q,w_b)
% Purpose:
%   compute the derivative of quaternion
%
% Input:
% - q:      quaternion from frame N to B, scalar last (4x1)
% - w_b:    angular rate of frame B with respect to frame N, expressed in
%           frame B [rad/s] (3x1)
%
% Output:
% - qdot:   derivative of quarternion (4x1)
%
% Author:  Kai Matsuka
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


qv = q(1:3);
qs = q(4);

qv_dot = 1/2*(qs*eye(3)+skew(qv))*w_b;
qs_dot = -1/2*qv'*w_b;

qdot = [qv_dot; qs_dot];

end