function [xdot] = eomAttitude(t,x,J_B,J_B_inv)
% Purpose:  
%   EOM for rigid body attitude dynamics. Assumes frame B is located at the
%   CG of the rotating object and is fixed to the object. Frame I is the
%   inertial frame.
%
% Input:
% - t:  time (not used, necessary for function handle for ODE45)
% - x:  state (7x1) 
%             x = [q_B_I w_B_I_B]
%       where
%           - q_b_i:    quaternion representation of atttiude of frame B
%                       with respect to frame I
%           - w_B_I_B:  angular rate of frame B with respect to I,
%                       expressed in frame B [rad/s] (3x1)
% - J_B: inertia matrix of rigid body, expressed in frame B [kg*m^2] (3x3)
%
% Output:
% - xdot:   time derivative of state (7x1)
%
% Author:
%   Kai Matsuka
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


q_B_I = x(1:4)/norm(x(1:4));
w_B_I_B = x(5:7);

qdot_B_I = kdeQuat(q_B_I,w_B_I_B);
skewW = [0          -w_B_I_B(3)  w_B_I_B(2);
         w_B_I_B(3)  0          -w_B_I_B(1);
        -w_B_I_B(2)  w_B_I_B(1)  0];
wdot = -J_B_inv*skewW*J_B*w_B_I_B;
xdot = [qdot_B_I; wdot];



end