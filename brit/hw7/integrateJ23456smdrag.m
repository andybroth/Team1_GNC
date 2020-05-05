function dy = integrateJ23456smdrag(t, y)
% Constants
gmu = 3.986004328969392e+05;
re = 6.378136000000000e+03;
AU = 1.496e+8;

musun = 1.3271e+11;
mumoon = 4.9028e+03;

J2 = 1.08262668e-03;
J3 = -2.5e-06;
J4 = -1.6e-06;
J5 = -0.21e-06;
J6 = 0.646e-06;


% Calculated
r = sqrt(y(1)^2 + y(3)^2 + y(5)^2);

vrel = sqrt(y(2)^2 + y(4)^2 + y(6)^2);

% Variables for drag 
rho = density(r)*1000;  %kg/km^3

masscraft = 1000; %kg
% Assuming 50 m^2 is the area
area = 50/1000^2;  % km^2
CD = 2;


% Convert time to Julian date
[jcr,jf] = jday(2020, 1, 1, 12, 0, 0);

jd = jcr + jf + t/86400;

[rsu, srtasc, sdecl] = sun(jd);
[rmon, mrtasc, mdecl] = moon(jd);

% Values for rates are randomly chosen
% Convert to r vectors
[rs, ~] = radec2rv(norm(rsu*AU), srtasc, sdecl, 1, 1, 1);
[rm, ~] = radec2rv(norm(rmon*AU), mrtasc, mdecl, 1, 1, 1);

rs = rs;
rm = rm;


sundiff = sqrt((y(1)-rs(1))^2 + (y(3)-rs(2))^2 + (y(5)-rs(3))^2);
moondiff = sqrt((y(1)-rm(1))^2 + (y(3)-rm(2))^2 + (y(5)-rm(3))^2);

j2 = -J2*(3/2)*(re/r)^2*(5*y(5)^2/r^2 - 1);
j3 =  J3*(5/2)*(re/r)^3*(3*y(5)/r - 7*y(5)^3/r^3);
j4 = -J4*(5/8)*(re/r)^4*(3 - 42*y(5)^2/r^2 + 63*y(5)^4/r^4);
j5 = -J5*(3/8)*(re/r)^5*(35*y(5)/r - 210*(y(5)^3/r^3)+231*(y(5)^5)/(r^5));
j6 = J6*(1/16)*(re/r)^6*(35-(945*(y(5)^2)/(r^2)) + (3465*y(5)^4/r^4) - (3003*y(5)^6/r^6));

sunperturbx = -musun*(((y(1)-rs(1))/(sundiff^3)) - (-rs(1)/(norm(rs)^3)));
sunperturby =  -musun*(((y(3)-rs(2))/(sundiff^3)) - (-rs(2)/(norm(rs)^3)));
sunperturbz =  -musun*(((y(5)-rs(3))/(sundiff^3)) - (-rs(3)/(norm(rs)^3)));

moonperturbx = -mumoon*(((y(1)-rm(1))/(moondiff^3)) - ((-rm(1)/(norm(rm)^3))));
moonperturby = -mumoon*(((y(3)-rm(2))/(moondiff^3)) - ((-rm(2)/(norm(rm)^3))));
moonperturbz = -mumoon*(((y(5)-rm(3))/(moondiff^3)) - ((-rm(3)/(norm(rm)^3))));

drag = -(1/2)*CD*area/masscraft*rho*vrel; % m^2/kg * kg/m^3 * km/s

dy = [y(2); ((-gmu*y(1)/r^3*(1 + j2 + j3 + j4 + j5 + j6))...
    + sunperturbx + moonperturbx + drag); 
    y(4); ((-gmu*y(3)/r^3*(1 + j2 + j3 + j4 + j5 + j6))+...
    sunperturby + moonperturby + drag);  
    y(6); ((-gmu*y(5)/r^3*...
    (1 + J2*(3/2)*(re/r)^2*(-5*y(5)^2/r^2 + 3)...
    + J3*(3/2)*(re/r)^3*(10*y(5)/r - (35/3)*y(5)^3/r^3 - r/(y(5)))...
    - J4*(5/8)*(re/r)^4*(15 - 70*y(5)^2/r^2 + 63*y(5)^4/r^4)...
    - J5*(1/8)*(re/r)^5*(315*y(5)/r - (945*(y(5)^3)/r^3) + 693*y(5)^5/r^5 -15*r/y(5))...
    + J6*(1/16)*(re/r)^6*(315 - 2205*y(5)^2/r^2 +4851*y(5)^4/r^4 - (3003*y(5)^6/r^6))))...
    + sunperturbz + moonperturbz + drag)]; 

end
