%% Test code for a single satellite
% relies on random_sat_start, find_pros, exppA_state, propagate_pro
% minDV, and plot_planar_pro.m

% Reset workspace
clear all;
clc;
close all;

% Known constants
mhu = 398600; %Gravitational constant of Earth in km^3/s^2
Re = 6378; % Radius of Earth  in km

% User edited variables
N = 1;                      % Number of satellites
center = [0,0,0];           % Location of chief (m)
mind = 50;                  % min distance from center (m)
maxd = 150;                 % max distance from center (m)
minv = 0.05;                % min injection velocity (m/s)
maxv =   0.2;               % max injection velocity (m/s)
radial_velocity_switch = 0; % 1 - only radial velocity, 0 - random
ca = 600;                   % Chief orbit altitude (km)
pro_max = 200;              %finding pro constraints max distance (m)
orbit_chief = 0;            % Switch orbit_chief - 1, yes; 0, no


% Stored in a state vector;
% Nx6 [x y z vx vy vz] form
% 0 - random vector between vmin and vmax
% 1 - radially outward from cygnus
% output - [x,y,z,xdot,ydot,zdot]; (m,m,m,m/s,m/s,m/s)
state_ejec = generate_random_sats(center, N, mind, maxd, minv, maxv,radial_velocity_switch);


% write distance to console
xyz = state_ejec(1:3);
vxyz = state_ejec(4:6);
disp('Distance: ');
disp(norm(xyz));
disp('Velocity: ');
disp(norm(vxyz));

% chief s/c value
a_chief = Re + ca; %semi-major axis of the orbit of the chief - km
period = 2*pi*sqrt(a_chief^3/mhu); %period of the chief orbit in seconds
n = 2*pi/period; % Mean motion in radians/second
%% AIMED PRO constraints
% Call function to calculate the possible PRO injection points
[state_potential,states] = find_pros(state_ejec, pro_max,n, orbit_chief);

figure;
title('Relative coordinate');
xlabel('x');
ylabel('y');
zlabel('z');
grid on;
plot3(states(:,1), states(:,2), states(:,3),'DisplayName','Ejection orbit');
hold on
plot3(state_ejec(1), state_ejec(2), state_ejec(3), '*', 'DisplayName','Ejection Location');
grid on
try
    plot3(state_potential(:,1), state_potential(:,2), state_potential(:,3),'rs', 'DisplayName','Potential candidates for firing');
catch
    disp('No PRO firing states found');
end

%% Get best PRO and plot it
% Use I(time index when injecting would give minimum velocity
% set that to be the initial state of the new PRO
try
    [mindv,I] = minDV(state_potential, n);
    location = state_potential(I,1:3); %fixing the location from the previous section
    [statePRO1,~] = propagate_pro(location, n, period);
    figure(1)
    hold on
    plot3(statePRO1(:,1), statePRO1(:,2), statePRO1(:,3), '--r');
    plot_planar_pro(statePRO1);
catch
    disp('Cannot plot nonexistant PRO');
end




