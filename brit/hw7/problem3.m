gmu = 3.986005*10^14;
re = 6378140;
J2 = 0.00108263;
RUNIT = re;
TUNIT = sqrt(re^3/gmu);
VUNIT = RUNIT/TUNIT;
AUNIT = VUNIT/TUNIT;


% Fixed
E = -0.45;
Hz = sqrt(0.3);

% Pseudo-Circular Initial Conditions in meridian plane
z = 0;
phi = 0;
rf = 1.11133496883;
rdot = 0;
[pdot,zdot] = poincare_conditions(rf, rdot, E, Hz);

period = 2* pi *sqrt((RUNIT*rf)^3*10^9/gmu);
tspan = linspace(0, 100*period, 100);
% Triangular Cluster Initial Conditions

r0 = [0.0;7*10^-6;0.0] + rf;
rd0 = [0;0;0];
phi0 = [10^-5;0;-10^-5];
z0 = [0;0;0];

% Calculations for each satellite's starting point
for i = 1:3
    [phid0(i), zd0(i)] = poincare_conditions(r0(i),rd0(i), E, Hz);
end


% Integrate the trajectories in the meridian plane for each individual
% satellite

[ct, cy] = odesolverrz(rf, rdot, z, zdot, phi, pdot, tspan);

n = 1;
[spc1t, spc1y] = odesolverrz(r0(n), rd0(n), z0(n), zd0(n), phi0(n), phid0(n), tspan);
n = 2;
[spc2t, spc2y] = odesolverrz(r0(n), rd0(n), z0(n), zd0(n), phi0(n), phid0(n), tspan);
n = 3;
[spc3t, spc3y] = odesolverrz(r0(n), rd0(n), z0(n), zd0(n), phi0(n), phid0(n), tspan);

for pt = 1:100
    circ(pt,:) = [cy(pt,1)*sin(cy(pt,5)), cy(pt, 3)];
    yz1(pt, :) = [spc1y(pt, 1)*sin(spc1y(pt, 5)), spc1y(pt, 3)];
    yz2(pt, :) = [spc2y(pt, 1)*sin(spc2y(pt, 5)), spc2y(pt, 3)];
    yz3(pt, :) = [spc3y(pt, 1)*sin(spc3y(pt, 5)), spc3y(pt, 3)];
end

figure(1);
plot(yz1(:,1), yz1(:,2), 'r');
hold on;
plot(yz2(:,1), yz2(:,2), 'b');
plot(yz3(:,1), yz3(:,2), 'k');
plot(circ(:,1),circ(:,2), 'g');
hold off;