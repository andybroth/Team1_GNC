function [state_dot] = eomErrQuat(state,J_B,J_B_inv,Q)
% Purpose:  
%   This function computes the time-derivative of the attitude state and
%   covariance. Use this in ode45 (or other integrator) as following
%
%     [t,y] = ode45(@(t,state) eomErrQuat(state,J_B,J_B_inv),time,state0)
%
% - state:   includes reference quaternion, angular rate and error
%            covariance state.
%                state = [q_B_I; w_B_I_B; reshape(P,36,1)]
%            where P is a 6x6 (symmetric) covariance matrix corresponding to
%            error states
%                errorstate = [error_att; error_w]
% - J_B:     moment of inertia (3x3)
% - J_B_inv: inverse of moment of inertia (3x3)
%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


q_B_I   = quatNorm(state(1:4));
w_B_I_B = state(5:7);
P       = reshape(state(8:end),6,6);
P       = enforce_symm(P);

% quaternion Kinematic Differential Equation
qdot_B_I = kdeQuat(q_B_I,w_B_I_B);

% angular rate kinematics
wdot = -J_B_inv*skew(w_B_I_B)*J_B*w_B_I_B;

% propagation of covariance
F = [-skew(w_B_I_B), eye(3); 
     zeros(3,6)];

G = [zeros(3); J_B_inv];
Pdot = F*P + P*F' + G*Q*G';

state_dot = [qdot_B_I;
             wdot;
             reshape(Pdot,[],1)];
         

end