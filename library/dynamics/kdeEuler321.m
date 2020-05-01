function [euler_dot] = kdeEuler321(t,euler,w_b)
% Purpose:
%   This is a ODE function that calculates kinematic differential equation
%   for Euler angles with 1-2-3 sequence from body rotation agnle. Angles
%   alpha, beta and gamma corresponds to the angle of rotation. In other
%   words, rotation of a vector from frame N to frame B can be written as
%
%           R_N2B = R_z(gamma)*R_y(beta)*R_x(alpha)
%
% Input:
% - t:          time (not used: argument needed for ODE solver)
% - euler:      euler angles for 1-2-3 sequence [rad] (3x1)
%                   euler = [alpha beta gamma]'
% - w_b:        rotation rate of frame B with respect to frame N, expressed
%               in frame B. [rad/s] (3x1)
%
% Output:
% - euler_dot:  rate of change of euler angles (1-2-3 sequence) [rad/s]
%               (3x1)
%
% References:
% - Markley, F.L., Crassidis, J.L., "Fundamentals of Spacecraft Attitude
%   Dtermination and Control." p.74, Springer, 2014.
% - AE105B Aerospace Engineering Homework 2
%
% Author:   Kai Matsuka
% Date:     2/3/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% rotation
beta  = euler(2);
gamma = euler(3);

GAMMA = [ cos(gamma)*sec(beta)   -sin(gamma)/cos(beta) 0;
          sin(gamma)               cos(gamma)           0;
         -cos(gamma)*tan(beta)    sin(gamma)*tan(beta) 1];
     
euler_dot = GAMMA*w_b;


end