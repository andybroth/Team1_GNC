%% Compute locations of all possible PROs
% state_ejec - ejection condition
% pro_max - maximum distance of pro
% orbit_chief - 1= yes, 0 = no
function [state_potential,states] = find_pros(state_ejec, pro_max, pro_min, n, orbit_chief, period)
%AIMED PRO constraints
%constrains
% (1) abs(y(0)) < x(0)
% (2) norm(position) < max_dist

state_potential = [];
options = optimset("TolX", 1e-2,"TolFun",0.5);
%only few locations along the initial path of the cubesat would be potential candidates for the burn
time = 0:10:10000; 
% Time = 0 is the time of ejection of the cubesat from the spacecraft
for i=1:1:length(time)
    states(i,1:6) = exppA_state(n,time(i))*state_ejec'; %HCW equations-closed form solution
    dist(i) = norm(states(i,1:3)); %find the distance between the deputy and the chief

    %check for the position constraints
    if (dist(i) < pro_max) %at the time of injeciton, the max distance constraint needs to be satisfied
        switch orbit_chief
            case 1
                if (abs(states(i,2))< abs(states(i,1))) % makes sure the deputy orbits around the chief
                    state_potential = [state_potential; states(i,1:6)]; %potential locations for firing
                end
            case 2
                if (abs(states(i,2))< abs(states(i,1))) % makes sure the deputy orbits around the chief
                    [min_d, max_d] = minmax_dist(states(i,:),options);
                    if min_d > pro_min && max_d < pro_max
                        state_potential = [state_potential; states(i,1:6)]; %potential locations for firing
                    end
                end
            otherwise
                state_potential = [state_potential; states(i,1:6)]; %potential locations for firing
        end      
    end
    if dist(i) > 300
        return
    end
end

end

function [min_d, max_d] = minmax_dist(states,options)
    px = abs(states(1));
    py = states(2);
    pz = abs(states(3));

    x = @(t) px*sin(t);
    y = @(t) py+2.*px.*cos(t);
    z = @(t)pz.*sin(t);
    dist = @(t) sqrt((px+pz)^2*sin(t)^2 + y(t)^2);
    neg_dist = @(t) -1 * dist(t);

    min_d = dist(fminbnd(dist, 0,pi,options));
    max_d = dist(fminbnd(neg_dist,0,pi,options));
end