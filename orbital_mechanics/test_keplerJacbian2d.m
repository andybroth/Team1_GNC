clear all;
close all;
clc;

defineConstants;
defineUnits;

mu_E = 3.986*1E5*KILOMETERS^3;
R_E = EARTH_RADIUS;

% input parameter
rvec0 = [-4743; 4743]*KILOMETERS;
vvec0 = [-5.879; -4.223]*KILOMETERS;
state0 = [rvec0;vvec0];
t0 = 0;
dt = 10*MINUTES;


for ii = 1:4
for jj = 1:4

    % nominal
    [~,y] = ode45(@(t,x) eomOrbit2d(t,x,mu_E), [0 dt], state0);
    state1 = y(end,:)';
    F = keplerJacbian2d(state0,dt,mu_E,R_E);

    N = 100;
    if jj == 1 || jj==2
        pert = linspace(-1000*KILOMETERS,1000*KILOMETERS,N);
    else
        pert = linspace(-1*KILOMETERS,1*KILOMETERS,N);
    end

    stateOut = zeros(4,N);

    for kk = 1:N

        state0_pert = [rvec0;vvec0];
        state0_pert(jj) = state0_pert(jj)+pert(kk);
        [~,y] = ode45(@(t,x) eomOrbit2d(t,x,mu_E), [0 dt], state0_pert);
        state1_pert = y(end,:)';
        [rvec_pert,vvec_pert] = kepler_prop(state0_pert(1:2),state0_pert(3:4),t0,t0+dt,mu_E);
        stateOut(:,kk) = state1_pert;

    end

    figure()
    plot(pert,stateOut(ii,:)); hold on;
    plot([pert(1) pert(end)],F(ii,jj)*[pert(1) pert(end)]+state1(ii));
    title(['test F(',num2str(ii),',',num2str(jj),')']);

end
end




