%% Propagate the PRO at this spot
% location - [x y z] location where the transfer occurs
% n - mean motion in radians per second
% period - period of chief orbit in seconds

function [state_PRO,r_PRO] = propagate_pro(location, n, period)
% Use I(time index when injecting would give minimum velocity
% set that to be the initial state of the new PRO
try
    X_PRO = location; %fixing the location from the previous section
    X_PRO = [X_PRO 0 -2*n*X_PRO(1) 0]; %period matching velocity constraints
    time_PRO= 0:10:period; %because period matching with the chief
    for i=1:1:length(time_PRO)
        state_PRO(i,:) = exppA_state(n, time_PRO(i))*X_PRO';
        r_PRO(i) = norm(state_PRO(i,1:3)); %distance of the deputy from the chief
    end
catch
    disp('Cannot plot nonexistant PRO');
end
end