%% Looking at cubesat reconvergence time

%%
% Reset workspace
clear all;
clc;
close all;

% Set Path
pathCurrDir = pwd;
addpath(genpath([pathCurrDir,'/library']));
%% Known constants
mhu = 398600; %Gravitational constant of Earth in km^3/s^2
Re = 6378; % Radius of Earth  in km

% User edited variables
N = 50000;                      % Number of satellites
center = [0,0,0];           % Location of chief (m)
mind = 15;                  % min distance from center (m)
maxd = 40;                 % max distance from center (m)
minv = 0.5;                % min injection velocity (m/s)
maxv =  2;               % max injection velocity (m/s)
radial_velocity_switch = 1; % 1 - only radial velocity, 0 - random
ca = 400;                   % Chief orbit altitude (km)
t_max = 7*24*60*60;
plt = 0;
pro_max = 200;              % finding pro constraints max distance (m)
pro_min = 50;               % min distance contraint (m)

state_ejec = generate_random_sats(center, N, mind, maxd, minv, maxv,radial_velocity_switch);

% chief s/c value
a_chief = Re + ca; %semi-major axis of the orbit of the chief - km
period = 2*pi*sqrt(a_chief^3/mhu); %period of the chief orbit in seconds
n = 2*pi/period; % Mean motion in radians/second

%% Relaxes restrictions on PRO search for x'(0) and z'(0)
%{
k = 1;
dv_total = 0;
f = waitbar(0,"Loading");
while k <= N
    % Call function to calculate the possible PRO injection points
    if N == 1
        [state_potential] = find_pros_relax(state_ejec, pro_max, pro_min, n, a_chief);
    else
        [state_potential] = find_pros_relax(state_ejec(k,:), pro_max, pro_min, n, a_chief);
    end
    
    try
        [mindv,min_xv,init_xv] = minDV_relax(state_potential, n);
        % [statePRO1,~] = propagate_pro(location, n, period);
        k = k + 1;
        dv_total = dv_total + mindv;
    catch
        % disp('Cannot plot nonexistant PRO');
        state_ejec(k,:) = generate_random_sats(center, 1, mind, maxd, minv, maxv,radial_velocity_switch);
    end
    if mod(k,N/100) == 0
        waitbar(k/N, f, 100*k/N+"% Done");
    end
end
close(f);
disp("Average delta v (m/s): "+dv_total/N);
%}
%% Propagates a random IC forward looking for recovergence period

loop = 2*pi*a_chief;
tinits = [2 12 24 36 48].*60.*6;
tmax = (1:7).*24.*60.*6;
t0 = 1;
fileID = fopen('return_data.txt','w');
while t0 <= length(tinits)
    tend = 1;
    while tend <= length(tmax)
        while tinits(t0) >= tmax(tend)
            tend = tend + 1;
        end
        returns = zeros(N, 1);
        dv = zeros(N,1);
        f = waitbar(0,"Loading");
        for j = 1:N
            t = tinits(t0);
            states = [];
            while t < tmax(tend)
                states(1:6) = exppA_state(n,t*10)*state_ejec(j,:)';
                if abs(states(2)) > loop/2
                    states(2) = mod(states(2),loop);
                end
                if states(2) > loop/2
                    states(2) = states(2) - loop;
                end

                if norm(states(1:3)) < 200
                    returns(j) = t*10;
                    t = t + tmax(tend);
                else
                    t = t + 1;
                end
            end
            if returns(j) == 0
                vy = state_ejec(j,5);
                vy_return = vy*tinits(t0)/(tmax(tend)-tinits(t0));
                dv(j) = abs(vy) + vy_return;
            end
            if mod(j,N/100) == 0
                waitbar(j/N, f, 100*j/N+"% Done with start "+tinits(t0)/360+"hr, end "+tmax(tend)/(24*360)+"days");
            end
        end
        t1 = "Start: "+tinits(t0)/360+"hr, end: "+tmax(tend)/(24*360)+"days";
        t2 = "Returns with no firing: "+sum(returns > 0)*100/N+"%";
        t3 = "Avg Delta v of firing Cubesats (m/s): "+sum(dv)/sum(dv>0);
        t4 = "Avg Delta v over all Cubesats  (m/s): "+sum(dv)/N;
        t5 = "Max Delta v impulse            (m/s): "+max(dv);
        endline = "\r\n";
        disp(t1);
        disp(t2);
        disp(t3);
        disp(t4);
        disp(t5);
        disp(" ");
        fprintf(fileID, t1+endline);
        fprintf(fileID, t2+endline);
        fprintf(fileID, t3+endline);
        fprintf(fileID, t4+endline);
        fprintf(fileID, t5+endline);
        fprintf(fileID, endline);
        close(f);
        tend = tend + 1;
    end
    t0 = t0 + 1;
end
fclose(fileID);
%{
count2 = 0;
count3 = 0;
count4 = 0;
count5 = 0;
for j = 1:N
    if returns(j) < 2*24*60*60
        count2 = count2 + 1;
        count3 = count3 + 1;
        count4 = count4 + 1;
    elseif returns(j) < 3*24*60*60
        count3 = count3 + 1;
        count4 = count4 + 1;
    elseif returns(j) < 4*24*60*60
        count4 = count4 + 1;
    end
end
disp("Total returns: "+N);
disp("Return <2 day percentage: "+100*count2/N);
disp("Return <3 day percentage: "+100*count3/N);
disp("Return <4 day percentage: "+100*count4/N);
disp("Average return time: "+mean(returns)/3600+"hr");
disp("STD: "+std(returns)/3600+"hr");
disp("Max return time: "+max(returns)/3600/24+"days");
%}
%%
% Plots ejection orbits
if plt
    figure(1);
    title('Relative coordinate');
    xlabel('x');
    ylabel('y');
    zlabel('z');
    grid on;
    hold on;
    plot3(states(:,1), states(:,2), states(:,3),'DisplayName',"Ejection orbit "+(i-1));
    radius = 10;
    [X,Y,Z] = sphere();
    surf(X*radius, Y*radius, Z*radius, 'DisplayName', 'Cygnus')
    axis equal
end


