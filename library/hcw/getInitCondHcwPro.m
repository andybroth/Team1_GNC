function [x0] = getInitCondHcwPro(n,r_in,r_out,ang_in,ang_off,offset)
% Purpose:
%   This function computes an initial condition requied to place a
%   spacecraft onto a passive relative orbit (PRO), with assumption of HCW
%   equation, given the semi-minar axis of relative orbit as "radius" and
%   "angle" defined on radial-tangential plane.
%
% ang_out = ang_in + ang_off;
%
% Input:
% - r_in:   "radius" of in-plane relative motion
% - r_in:   "radius" of out-of-plane relative motion
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ang_out = ang_in + ang_off;

dt_in  = ang_in/n;
dt_out = ang_out/n;

x_in  = hcw_sol(n,dt_in,  [0, offset+2*r_in,  0, r_in*n, 0, 0]');
x_out = hcw_sol(n,dt_out, [0, 0, 0, 0, 0, r_out*n]');

x0 = [ x_in(1:2); 
       x_out(3);
       x_in(4:5);
       x_out(6)];
     

end