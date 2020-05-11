function [mindeltav,min_xv,init_xv] = minDV_relax(state_potential, n)
% For period matching we want xdot and zdot to be zero and ydot = -2n*x(0).
szsp = size(state_potential);
options = optimset("TolX", 1e-2,"TolFun",0.5);
count = 0;
for j=1:szsp(1)
    vxi = state_potential(j,4);
    vzi = state_potential(j,6);
    vx_range = [0 vxi];
    vz_range = [0 vzi];
    for vx = vx_range
        for vz = vz_range
            vec = [state_potential(j,1:3) vx -2*n*(state_potential(j,1)) vz];
            if formsPRO(vec, n, options)
                count = count + 1;
                velocity_beforeburn = state_potential(j,4:6);
                delta_v = vec(4:6)-velocity_beforeburn;
                DELTAV(count) = norm(delta_v); 
                xv_after(count,:) = vec;
                xv_before(count,:) = state_potential(j,:);
            end
        end
    end
end
try
    [mindeltav,I] = min(DELTAV); % min deltav in m/s
    min_xv = xv_after(I,:);
    init_xv = xv_before(I,:);
catch
    % disp('No delta V found');
end
end

function [flag] = formsPRO(vec, n, options)
flag = true;

px = sqrt(vec(4)^2+(vec(1)*n)^2)/n;
py = vec(2) - 2*vec(4)/n;
pz = sqrt(vec(6)^2+(vec(3)*n)^2)/n;

% apply constraint |py| < 2px
if ~(abs(py) < 2*px)
    flag = false;
    return;
end

% Makes sure PRO doesn't get within 50m
if min_d([px,py,pz], options) < 50
    flag = false;
    return;
end
end

function [min_d] = min_d(p,options)
y = @(t) p(2)+2.*p(1).*cos(t);
dist = @(t) sqrt((p(1)+p(3))^2*sin(t)^2 + y(t)^2);

min_d = dist(fminbnd(dist, 0,pi,options));
end