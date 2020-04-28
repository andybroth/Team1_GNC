function Phi = keplerJacbian2d(state,dt,mu_E,R_E)
% Purpose:
%   This computes the discrete-time dynamcis Jacobian for absolute orbital
%   dynamics. This function uses numerical differential to compute the
%   Jacobian
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% estimate state time update

[~,y_transEst] = ode45(@(t,x) eomOrbit2d(t,x,mu_E), [0 dt], state);
state_next = y_transEst(end,:)';

nState = 4;
epsilon = 1E-6;

Phi = zeros(nState);
for ii = 1:nState
    state_pert = state;
    if ii == 1 || ii == 2
        delta = R_E*epsilon;
        state_pert(ii) = state_pert(ii) + delta;
    else
        delta = mu_E/R_E^2*epsilon;
        state_pert(ii) = state_pert(ii) + delta;
    end
    [~,y_pert] = ode45(@(t,x) eomOrbit2d(t,x,mu_E), [0 dt], state_pert);
    state_next_pert = y_pert(end,:)';
    Phi(:,ii) = (state_next_pert-state_next)/delta;
end

end


