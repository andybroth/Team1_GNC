function [x,Phi] = hcw_sol_rescaled(n,t,x0)
% Purpose:
%   solution to the HCW equation. 
%
% RESCALED VERSION:
%   This assumes that position is expressed in [m] and velocity component
%   is expressed in [mm/s] This approach may be favorable for numerical
%   accuracy of filter.
%
% x: radial, y: along-track, z:cross-track
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Phi_rr = [4-3*cos(n*t)      0  0;
          6*(sin(n*t)-n*t)  1  0;
          0                 0  cos(n*t)];

Phi_rv = [ sin(n*t)/n       (1-cos(n*t))*2/n      0;
          (cos(n*t)-1)*2/n  (4*sin(n*t)-3*n*t)/n  0;
           0                 0                    sin(n*t)/n];

Phi_vr = [3*n*sin(n*t)     0   0;
          6*n*(cos(n*t)-1) 0   0;
          0                0  -n*sin(n*t)];

Phi_vv = [ cos(n*t)   2*sin(n*t)    0;
          -2*sin(n*t) 4*cos(n*t)-3  0;
           0          0             cos(n*t)];
Phi = [Phi_rr       Phi_rv/1000;
       Phi_vr*1000  Phi_vv];
   
x = Phi*x0;
    
end