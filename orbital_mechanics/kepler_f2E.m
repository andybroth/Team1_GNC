function E = kepler_f2E(f,e)
% Purpose:
%   This function converts the Eccentric anomaly (E) to true anomaly (f)
%   using a method robust to quadrant disambiguity.
% 
%   Refer to Eq 2.11 and Problem 2.1 in Ref [1].
%
% Ref:
% [1] Prussing, John E., and Bruce A. Conway. Orbital mechanics. Oxford
%     University Press, USA, 1993. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tanE2 = tan(f/2)*((1-e)/(1+e))^0.5;
E = atan(tanE2)*2;

end



