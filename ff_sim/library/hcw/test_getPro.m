clear all; 
close all;



defineConstants;
defineUnits;

h = 400*KILOMETERS;     % alittude below ISS
a = h+EARTH_RADIUS;     % semi-major axis
n = sqrt(EARTH_GRAV_CONST/a^3);

N = 3;
r_in = 100;
r_out = 100;
offset = 0;
ang_vec = 2*pi/N*[0:(N-1)];
x0 = getPro(n,r_in,r_out,ang_vec,offset);

T = 2*pi/n;
tVec = linspace(0,0.2*T);
visualizeHcw(x0,n,tVec);

