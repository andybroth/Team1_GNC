clear all;
clc;


pos = [500 500]'*1000;
vel = [-7 7]'*1000;

R_L_I = eci2lvlh2d(pos,vel);

R_L_I*[1; 0]
R_L_I*[0; 1]
