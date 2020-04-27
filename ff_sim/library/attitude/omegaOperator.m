function [Omega] = omegaOperator(w)
% Purpose:
%   This function returns omega used for kinematic differential equation of
%   quaternion: 
%       qdot = 1/2*Omega(w)*q
%
% Author:   Kai Matsuka
% Ref: 
%   [1] Markley, F. Landis, and John L. Crassidis. Fundamentals of
%       spacecraft attitude determination and control. Vol. 33. New York:
%       Springer, 2014.  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Omega = [-skew(w) w;
          -w'     0];

end

