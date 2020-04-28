function E = kepler_M2E(M,e)
% Purpose: 
%   This function computes the eccentric anomaly, given mean anomaly and
%   eccentricity. The solution is obtained by solving an implicit equation.
%   The solution always exists and is unique.
%
%   Refer to Eq 2.13 in Ref [1].
%
% Ref:
% [1] Prussing, John E., and Bruce A. Conway. Orbital mechanics. Oxford
%     University Press, USA, 1993. 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mute fsolve display
options = optimoptions('fsolve','Display','none');

E= zeros(size(M));
for ii = 1:length(E(:))
    fun = @(x) x-e*sin(x)-M(ii);  
    E(ii) = fsolve(fun,M(ii),options);
end

end

