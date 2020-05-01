function [x0] = getInitCondHcwPro2d(n,r_in,ang_in,offset)
% Purpose:
%   This function computes an initial condition requied to place a
%   spacecraft onto a passive relative orbit (PRO), with assumption of HCW
%   equation, given the semi-minar axis of relative orbit as "radius" and
%   "angle" defined on radial-tangential plane.
%
%
% Input:
% - n:      mean motion
% - r_in:   "radius" of in-plane relative motion
% - ang_in: initial angle with respect to R axis
% - offset: offset of PRO in along-track direction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dt_in = ang_in/n;
x0  = hcw2d_sol(n,dt_in,  [0, offset+2*r_in, r_in*n, 0]');
     
end