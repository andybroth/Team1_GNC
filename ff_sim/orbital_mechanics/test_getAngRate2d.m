clear all;
close all;
clc;

pos = [sqrt(1/2) sqrt(1/2)]';
vel = [-sqrt(1/2) sqrt(1/2)]'*5;


getAngMom2d(pos,vel)
getAngRate2d(pos,vel)