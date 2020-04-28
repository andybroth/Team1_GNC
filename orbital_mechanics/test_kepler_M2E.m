clear all;
close all;
clc;


evec = 0.5;
Mvec = linspace(-2*pi,2*pi,100);

figure()
for ii = 1:length(evec)
    e = evec(ii);
    tic
    Evec = kepler_M2E(Mvec,e);
    toc
    plot(Mvec,Evec);
    if ii == 1
        hold on;
    end
end

