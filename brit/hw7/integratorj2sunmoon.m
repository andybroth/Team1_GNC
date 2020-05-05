function dy = integratorj2sunmoon(t, y)
% Constants
gmu = 3.986004328969392e+05;
re = 6.378136000000000e+03;
AU = 1.496e+8;

musun = 1.3271e+11;
mumoon = 4.9028e+03;

J2 = 1.08262668*10^-03;

% Calculated
r = sqrt(y(1)^2 + y(3)^2 + y(5)^2);

% Convert time to Julian date
[jcr,jf] = jday(2020, 1, 1, 12, 0, 0);

jd = jcr + jf + t/86400;

[rsu, srtasc, sdecl] = sun(jd);
[rmo, mrtasc, mdecl] = moon(jd);

% Values for rates are randomly chosen
% Convert to r vectors
[rs, ~] = radec2rv(norm(rsu*AU)/re, srtasc, sdecl, 1, 1, 1);
[rm, ~] = radec2rv(norm(rmo*AU)/re, mrtasc, mdecl, 1, 1, 1);

rs = rs*re;
rm = rm*re;

sundiff = sqrt((y(1)-rs(1))^2 + (y(3)-rs(2))^2 + (y(5)-rs(3))^2);
moondiff = sqrt((y(1)-rm(1))^2 + (y(3)-rm(2))^2 + (y(5)-rm(3))^2);

j2 = -J2*(3/2)*(re/r)^2*(5*y(5)^2/r^2 - 1);

sunperturbx = -musun*(((y(1)-rs(1))/(sundiff^3)) - (-rs(1)/(norm(rs)^3)));
sunperturby =  -musun*(((y(3)-rs(2))/(sundiff^3)) - (-rs(2)/(norm(rs)^3)));
sunperturbz =  -musun*(((y(5)-rs(3))/(sundiff^3)) - (-rs(3)/(norm(rs)^3)));

moonperturbx = -mumoon*(((y(1)-rm(1))/(moondiff^3)) - ((-rm(1)/(norm(rm)^3))));
moonperturby = -mumoon*(((y(3)-rm(2))/(moondiff^3)) - ((-rm(2)/(norm(rm)^3))));
moonperturbz = -mumoon*(((y(5)-rm(3))/(moondiff^3)) - ((-rm(3)/(norm(rm)^3))));

dy = [y(2); ((-gmu*y(1)/r^3*(1 + j2 ))...
    + sunperturbx + moonperturbx); 
    y(4); ((-gmu*y(3)/r^3*(1 + j2))+...
    sunperturby + moonperturby);  
    y(6); ((-gmu*y(5)/r^3*...
    (1 + J2*(3/2)*(re/r)^2*(-5*y(5)^2/r^2 + 3)))...
    + sunperturbz + moonperturbz)]; 

end