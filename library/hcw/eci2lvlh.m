function R_L_I = eci2lvlh(posRef_I_I,velRef_I_I)
% Purpose:
%   Compute rotation from ECI to LVLH frame.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


angMom = cross(posRef_I_I,velRef_I_I);
r_I = posRef_I_I/norm(posRef_I_I);
n_I = angMom/norm(angMom);
t_I = cross(n_I,r_I);
R_L_I = [r_I t_I n_I]';

end