function x0 = getProArbitPos_curvLin(n,absStateRef,relPos_vec,grav_param)
% Purpose:
%   This function provides the initial relative state that will yield no
%   relative drift in nonlinear dynamics
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


N = size(relPos_vec,2);
x0 = zeros(4,N);

for ii = 1:N
    
    relPos = relPos_vec(:,ii);
    relRadius = sqrt(relPos(1).^2+(relPos(2)/2).^2);
    theta = atan2(relPos(1),relPos(2)/2); % theta is measured from T
    t = theta/n;

    pos_r_r0 = [0; 2*relRadius];
    vel_r_r0 = [pos_r_r0(2)*n/2;0];

    % propagate backward in time the reference spacecraft 
    [~,y] = ode45(@(t,x) eomOrbit2d(t,x,grav_param),[0 -t],absStateRef);
    absStateRef0 = y(end,:)';

    [posAbsSc0, velAbsSc0] = hcwRel2abs2d(pos_r_r0,vel_r_r0,absStateRef0(1:2),absStateRef0(3:4));
    absStateSc0 = [posAbsSc0; velAbsSc0];
    
    % propagate forward the spacecraft
    [~,y] = ode45(@(t,x) eomOrbit2d(t,x,grav_param),[0 t],absStateSc0);
    absStateSc = y(end,:)';
    [posSc_L_L,velSc_L_L] = hcwAbs2rel2d(absStateSc(1:2),absStateSc(3:4),absStateRef(1:2),absStateRef(3:4));

    x0(:,ii) = [posSc_L_L;velSc_L_L];
    
end


end


