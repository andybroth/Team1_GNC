clear all;
close all;

defineConstants;
defineUnits;

x0 = [600;0]*KILOMETERS+EARTH_RADIUS;
v0 = [0;7]*KILOMETERS;
state0 = [x0; v0];
N = 100;
tVec = linspace(0,1.5*HOURS,N);

state_out = zeros(4,N); state_out(:,1) = state0;
for ii = 2:N
    [~,y_trans] = ode45(@(t,x) eomOrbit2d(t,x,EARTH_GRAV_CONST), [0 tVec(ii)], state0);  
    state_out(:,ii) = y_trans(end,:)';
end

figure()
plot(state_out(1,:),state_out(2,:));
axis('equal');