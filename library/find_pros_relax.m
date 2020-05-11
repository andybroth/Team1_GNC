%% Compute locations of all possible PROs
% state_ejec - ejection condition
% pro_max - maximum distance of pro
% orbit_chief - 1= yes, 0 = no
function [state_potential] = find_pros_relax(state_ejec, pro_max, pro_min, n, a_chief)
%AIMED PRO constraints
%constrains
% (1) abs(y(0)) < x(0)
% (2) norm(position) < max_dist

state_potential = [];
%only few locations along the initial path of the cubesat would be potential candidates for the burn
time = 0:10:10000; 
% Time = 0 is the time of ejection of the cubesat from the spacecraft
count = 0;
for i=1:1:length(time)
    states(1:6) = exppA_state(n,time(i))*state_ejec'; %HCW equations-closed form solution
    loop = 2*pi*a_chief;
    if abs(states(2)) > loop/2
        states(2) = mod(states(2),loop);
    end
    if states(2) > loop/2
        states(2) = states(2) - loop;
    end
    
    dist = norm(states(1:3)); %find the distance between the deputy and the chief

    %check for the position constraints
    if (dist < pro_max) && (dist > pro_min) %at the time of injeciton, the max distance constraint needs to be satisfied
        count = count + 1;
        state_potential(count,:) = states(1:6); %potential locations for firing     
    end
end

end