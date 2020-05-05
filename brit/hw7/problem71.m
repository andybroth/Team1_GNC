%% GEO Orbit Integrated for 10 years 
clc;

addpath('./hw1');
addpath('./matlab');

% Orbital elements at start
a = 42164;
ecc = 0;
ic = 0;
Omega = 0;
w = 0;
nu = 0;

% Calculate the dates using the datetime functionality
t0 = datetime(2020, 1, 1, 12, 0, 0);
tf = datetime(2030, 1, 1, 12, 0, 0);
ctimes = t0:calmonths(6):tf;

% Get difference between dates in hours
dt = diff(ctimes);
dts = seconds(dt);
current = dts(1);
in = 1;
tspan(1) = 0;
% Get a timespan for the integrator
while in <= 20
    tspan(in+1) = current;
    current = current + dts(in);
    in = in + 1;
end

[t,y] = odesolverj2sunmoon(a,a, Omega, ic, w, nu,tspan);

%% Can be run separately to check position

r = y(:, [1 3 5]);
v = y(:, [2 4 6]);

figure(1);
scatter3(r(:,1), r(:,2), r(:,3));


%%

for i = 1:21
    [~,an(i),ec(i), in(i),~] = rv2coe(r(i,:).',v(i,:).');
end

figure(2);
subplot(3,1,1)
plot(ctimes, an);
xlabel('Time since noon, Jan 1, 2020') 
ylabel('a')
hold on;

subplot(3,1,2)
plot(ctimes,ec);
xlabel('Time since noon, Jan 1, 2020') 
ylabel('eccentricity')

subplot(3,1,3)
plot(ctimes,in);
xlabel('Time since noon, Jan 1, 2020') 
ylabel('inclination')
hold off;