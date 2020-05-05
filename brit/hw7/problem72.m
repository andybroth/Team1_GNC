%% Elliptical Phasing Orbits with Drag
clc;
clear all;

gmu = 3.986004328969392e+05;
re = 6.378136000000000e+03;
AU = 1.496e+8;

rp = re + 200;

tp = 6*24*60*60;
a = ((tp/(2*pi))^2*6.674e-11*5.97219e+24/(1000^3))^(1/3);  % in km seconds^2*m^3*kg^-1*s^-2*kg
e = 1-rp/a;
ra = a*(1+e);
i = 28.5 * pi / 180;
Omega = 0;
w = 0;
nu = 0;

tspan = linspace(0,30*24,30*24);

[t,y] = odesolverj23456smdrag(ra, rp, Omega, i, w, nu,tspan);

%%
r = y(:, [1 3 5]);
v = y(:, [2 4 6]);

figure(1);
scatter3(r(:,1), r(:,2), r(:,3));


%%

for i = 1:720
    [~,an(i),ec(i), in(i),~] = rv2coe(r(i,:).',v(i,:).');
end

figure(2);
subplot(3,1,1)
plot(t, an);
xlabel('Time since noon, Jan 1, 2020') 
ylabel('a')
hold on;

subplot(3,1,2)
plot(t,ec);
xlabel('Time since noon, Jan 1, 2020') 
ylabel('eccentricity')

subplot(3,1,3)
plot(t,in);
xlabel('Time since noon, Jan 1, 2020') 
ylabel('inclination')
hold off;

