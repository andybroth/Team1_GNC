
function [t, y] = odesolverrz(r0, rd0, z0, zd0, p0, pd0, tspan)

opts = odeset('Reltol',1e-15,'AbsTol',1e-15,'Stats','on');

y0 = [r0, rd0, z0, zd0, p0].';

[t,y] = ode113(@integraterz, tspan, y0, opts);
end