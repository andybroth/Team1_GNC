function F = kepler_stm(rvec0,vvec0,t0,dt,mu_E,R_E)
% Purpose:
%   This function computes the dynamics Jacobian of the Keplarian orbit via
%   numerical differentiation.
%
% Input:
% - rvec0:  initial position vector
% - vvec0:  initial velocity vector
% - t0:     initial itme
% - dt:     discrete propogated time step
% - mu_E:   standard gravitational constant
% - R_E:    radius of Earth
%
% Output:
% - F:      dynamics Jacobian (4x4)
%
% Ref:
% [1] Prussing, John E., and Bruce A. Conway. Orbital mechanics. Oxford
%     University Press, USA, 1993. 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% nominal 
[rvec,vvec] = kepler_prop(rvec0,vvec0,t0,t0+dt,mu_E);
epsilon = 1E-6;

F = zeros(4);
for ii = 1:4
   
    if ii == 1 || ii == 2
        rvec0_pert = rvec0;
        delta = R_E*epsilon;
        rvec0_pert(ii) = rvec0_pert(ii) + delta;
        [rvec_pert,vvec_pert] = kepler_prop(rvec0_pert,vvec0,t0,t0+dt,mu_E);
    else
        vvec0_pert = vvec0;
        delta = mu_E/R_E^2*epsilon;
        vvec0_pert(ii-2) = vvec0_pert(ii-2) + delta;
        [rvec_pert,vvec_pert] = kepler_prop(rvec0,vvec0_pert,t0,t0+dt,mu_E);
    end
    F(1:2,ii) = (rvec_pert-rvec)/delta;
    F(3:4,ii) = (vvec_pert-vvec)/delta;
    
end

end


