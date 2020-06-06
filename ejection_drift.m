clear all;
close all;

mhu = 398600; %Gravitational constant of Earth in km^3/s^2
Re = 6378; % Radius of Earth  in km
ca = 400;

center = [0,0,0];           % Location of chief (m)
mind = 0;                  % min distance from center (m)
maxd = 1;                 % max distance from center (m)
minv = 0.5;                % min injection velocity (m/s)
maxv =  2;               % max injection velocity (m/s)
radial_velocity_switch = 1; % 1 - only radial velocity, 0 - random

a_chief = Re + ca; %semi-major axis of the orbit of the chief - km
period = 2*pi*sqrt(a_chief^3/mhu); %period of the chief orbit in seconds
n = 2*pi/period; % Mean motion in radians/second

time = 1:60*60*2*1;
states = zeros(length(time),6);
dist = zeros(length(time),1);

state_ejec = [0 0 0 1 0.035 0];
loop = 2*pi*a_chief;

for t = time
    states(t,:) = exppA_state(n, (t-1)*10)*state_ejec';
    if states(t,2) > loop/2
        states(t,2) = states(t,2) - loop;
    end
    dist(t) = norm(states(t,1:3));
end
figure(1);
plot(states(:,2),states(:,1));

figure(2);
plot3(states(:,1),states(:,2),states(:,3))
xlabel('x');
ylabel('y');
zlabel('z');

figure(3);
plot(time/3600, dist)
xlabel('Time (hrs)');
ylabel('Distance from chief (m)');