function r = kepler_E2r(E,a,e)
% Purpose:
%   This function computes the orbit radius as a funciton of eccentric
%   anomaly.
%
%   Refer to Eq 2.12 in Ref [1].
%
% Ref:
% [1] Prussing, John E., and Bruce A. Conway. Orbital mechanics. Oxford
%     University Press, USA, 1993. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


r = a*(1-e*cos(E));

end