close all;
clear all;

setmoon;
setearth;

%% Problem 3b

TE = EARTH.period;
j2 = EARTH.j2;
gmu = EARTH.gm;
r = EARTH.radius;
Om = 2*pi/TE;

a1 = (3*j2*r^2*sqrt(gmu)/(2*Om))^(2/7)

%% Problem 3c

D = 3;
N = 16;
wE = 7.2921159e-5;

a2 = (D*sqrt(gmu)/(wE*N))^(2/3)

%% Problem 3d

D = 12;
N = 179;
a3 = (D*sqrt(gmu)/(wE*N))^(2/3)
inc = -4*pi*a3^(7/2)/(3*TE*j2*r^2*sqrt(gmu));
inc = rad2deg(acos(inc))

%% Problem 4

mu = EARTH.mu;
B1 = [-mu,0,0]';
B2 = [(1 - mu),0,0]';

r1 = @(r) norm(r - B1);
r2 = @(r) norm(r - B2);

U = @(r) 1/2*(r(1).^2 + r(2)^2) + (1 - mu)./r1(r) + mu./r2(r);

C = 3.0004;

% Phi is 90-latitude
phi_a = deg2rad([90,90,90,90]);
phi_b = deg2rad([60,60,60,60]);

theta = deg2rad([180,270,0,90]);

%Speed of Earth's rotation to be added later
s_a = 2*pi/86400*EARTH.radius*sin(phi_a);
s_b = 2*pi/86400*EARTH.radius*sin(phi_b);

r = EARTH.radius/RUNIT;
x_a = r*sin(phi_a).*cos(theta) + (1 - mu);
y_a = r*sin(phi_a).*sin(theta);
z_a = r*cos(phi_a);

x_b = r*sin(phi_b).*cos(theta) + (1 - mu);
y_b = r*sin(phi_b).*sin(theta);
z_b = r*cos(phi_b);

for ind1 = 1:4
   a = [x_a(ind1),y_a(ind1),z_a(ind1)]';
   b = [x_b(ind1),y_b(ind1),z_b(ind1)]';
   
   vOut_a(ind1) = sqrt(2*U(a) - C);  
   vOut_b(ind1) = sqrt(2*U(b) - C);  
end

vDim_a = vOut_a*VUNIT+s_a
vDim_b = vOut_b*VUNIT+s_b

