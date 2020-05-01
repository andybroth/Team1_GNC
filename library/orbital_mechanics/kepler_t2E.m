function E = kepler_t2E(t0,E0,t,e,n)
% Purpose:
%   Computes the eccenric anomaly (E) propagaged from (E0) over time t-t0
%
% Input:
% - t0:     initial time
% - E0:     eccentric anomaly at initial time
% - t:      final time
% - e:      eccentricity
% - n:      mean motion 
% Output:
% - E:      eccentric anomaly at final time
%
%   Refer to Eq 2.13 and Example 2.2 in Ref [1].
%
% Ref:
% [1] Prussing, John E., and Bruce A. Conway. Orbital mechanics. Oxford
%     University Press, USA, 1993. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

options = optimoptions('fsolve','Display','none');
fun = @(x) x-e*sin(x)-(E0-e*sin(E0))- n*(t-t0);
E = fsolve(fun,E0+n*(t-t0),options);


end