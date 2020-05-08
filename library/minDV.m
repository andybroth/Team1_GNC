function [mindeltav,I] = minDV(state_potential, n)
% For period matching we want xdot and zdot to be zero and ydot = -2n*x(0).
szsp = size(state_potential);
for j=1:1:szsp(1)
   velocity_afterburn = [0 -2*n*(state_potential(j,1)) 0];
   velocity_beforeburn = state_potential(j,4:6);
   delta_v = velocity_afterburn-velocity_beforeburn;
   DELTAV(j) = norm(delta_v); 
end
try
    [mindeltav,I] = min(DELTAV); % min deltav in m/s
catch
    % disp('No delta V found');
end
end