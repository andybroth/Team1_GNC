clear all; 
close all; 
clc;

% define constants/unit conversion
defineUnits;
defineConstants;



%% simulation parameters

dtSim = 1;      % simulation time steps
tEnd = 2*HOURS; % simulation end time

%% chief orbital parameters

h = 300*KILLOMETERS;            % altitude [m]
a = EARTH_RADIUS + h;           % orbit radius [m]
n = sqrt(EARTH_GRAV_CONST/a^3); % mean anomaly [rad/s]

%% intitial conditions

posTrue_L_L   = [0 2*5 0]';  
velTrue_L_L   = [5*n 0 1*n]';
stateTrue = [posTrue_L_L; velTrue_L_L];

%% compuation

tVec = [0:dtSim:tEnd];
nStep = length(tVec);


stateTrue_out = zeros(6,nStep); stateTrue_out(:,1) = [posTrue_L_L;velTrue_L_L];

for ii = 1:nStep
    stateTrue_out(:,ii) = hcw_sol(n,tVec(ii),stateTrue);
end


% test getInitCondHcwPro

r_in = 5;
r_out = 1;
ang_in = 100*DEGREES;
ang_off = 0*DEGREES;    % angular offset between in-plane / out-of-plane motion
offset = 0;
xTest0 = getInitCondHcwPro(n,r_in,r_out,ang_in,ang_off,offset);

figure()
plot(stateTrue_out(1,:),stateTrue_out(2,:)); hold on;
plot(xTest0(1),xTest0(2),'x');
xlabel('R'); ylabel('T');
axis('equal');

figure()
plot(stateTrue_out(1,:),stateTrue_out(3,:)); hold on;
plot(xTest0(1),xTest0(3),'x');
xlabel('R'); ylabel('N');
axis('equal');
