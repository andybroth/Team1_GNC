function R_L_I = eci2lvlh2d(posRef_I_I,velRef_I_I)
% Purpose:
%   Compute rotation from ECI to LVLH frame.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nr_I = posRef_I_I/norm(posRef_I_I);
nt_I = [nr_I(2); -nr_I(1)];
if dot(nt_I,velRef_I_I)
    nt_I = -nt_I;
end

R_L_I = [nr_I, nt_I]';

end

