function [xip,xfm,deltav] = relativeLambert(xi,xf,n,dt)
% Purpose:
%   This function computes the relative transfer orbit given initial and
%   terminal positions and the prescribed transfer time. For small delta V,
%   choose dt such that it's integer multiple of the orbital period. If
%   initial and terminal velocities are provided, deltav provides the sum
%   of 2-norm delta-V's.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,phi] = hcw_sol(n,dt,nan(6,1)); 

pos_i_m = xi(1:3);
vel_i_m = xi(4:6);
pos_f_p = xf(1:3);
vel_f_p = xf(4:6);

phi_rr = phi(1:3,1:3);
phi_rv = phi(1:3,4:6);
phi_vr = phi(4:6,1:3);
phi_vv = phi(4:6,4:6);

% velocity immediately after first impulsive maneuver
% vel_i_p_AT = phi_rv(2,2)\(pos_f_p(2)-phi_rr(2,:)*pos_i_m(1:3));
% vel_i_p = [0 vel_i_p_AT 0]';
vel_i_p = phi_rv\(pos_f_p-phi_rr*pos_i_m);
vel_f_m = phi_vr*pos_i_m + phi_vv*vel_i_p;  % terminal velcoity, before impulse

% initial and final states of the transfer orbit
xip = [pos_i_m; vel_i_p];
xfm = [pos_f_p; vel_f_m];

% total deltav
delta_v_i = norm(vel_i_p-vel_i_m);
delta_v_f = norm(vel_f_p-vel_f_m);
deltav = delta_v_i + delta_v_f;


end

