clear all;
close all;
clc;
rng(1);

n = 0.0011;
nAgent = 10;
pos_vec = [10*randn(2,nAgent); zeros(1,nAgent)];
x0 = getProArbitPos(n,pos_vec,true);

tVec = 0:1.5*3600;
visualizeHcw(x0,n,tVec);
