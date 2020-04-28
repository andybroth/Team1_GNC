clear all;
close all;
clc;


defineConstants;
defineUnits;

a = 500*KILOMETERS + EARTH_RADIUS;
e = 0.1;
tvec = linspace(0,2*HOURS,1000);

[r,f,x,y] = kepler_traj(a,e,EARTH_GRAV_CONST,tvec);

figure()
plot(x,y);

figure()
plot(tvec,f/DEGREES)
xlabel('time');ylabel('True Anom(f) [deg]');


