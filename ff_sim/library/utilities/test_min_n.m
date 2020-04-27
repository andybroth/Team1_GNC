clear all;
close all;
clc;
rng(1)


n = 3;
x = randi(1000,10,1);
[vals,indices] = min_n(x,n)
