function Phi = keplerJacbian(state,dt,EARTH_GRAV_CONST)
% Purpose:
%   This computes the discrete-time dynamcis Jacobian for absolute orbital
%   dynamics. This function uses numerical differential to compute the
%   Jacobian
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% estimate state time update

[~,y_transEst] = ode45(@(t,x) eomOrbit(t,x,EARTH_GRAV_CONST), [0 dt], state);
state_next = y_transEst(end,:)';

nState = 6;
epsilon = 1E-6;

Phi = zeros(nState);
for ii = 1:nState
    state_pert = state;
    state_pert(ii) = state_pert(ii) + epsilon;

    [~,y_pert] = ode45(@(t,x) eomOrbit(t,x,EARTH_GRAV_CONST), [0 dt], state_pert);
    state_next_pert = y_pert(end,:)';
    Phi(:,ii) = (state_next_pert-state_next)/epsilon;
end

end


