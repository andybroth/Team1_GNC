%  Function to find density at some altitude
%
%  Input
%       r - altitude + radius of the earth in km
%       
%
%

function rho = density(r)

re = 6.378136000000000e+03;
alt = r - re;

load('atmosphereData.mat');
dat = atmosphereData;

i = 1;
zvals = zeros(923,1);
densites = zeros(923,1);

for row = 1:10
    num = cast(dat(row,2) - dat(row,1),'uint8');
    for zn = 1:num-1     
        A = dat(row, 3);
        B = dat(row, 4);
        C = dat(row, 5);
        D = dat(row, 6);
        E = dat(row, 7);
        z = cast(zn,'double') + dat(row,1);
        densities(i, 1) = exp(A*z^4 + B*z^3 + C*z^2+D*z+E);
        zval(i,1) = z; 
        i = i+1;
    end
end

if alt < 86
    rho = spline(zval, densities, (r - re));
elseif alt > 1000
    rho = 0;
else
    if alt < 91
        row = 1;
        rho = exp(dat(row,3)*alt^4 + dat(row,4)*alt^3 + dat(row,5)*alt^2 ...
    + dat(row,6)*alt + dat(row,7));
    elseif alt < 100
        row = 2;
        rho = exp(dat(row,3)*alt^4 + dat(row,4)*alt^3 + dat(row,5)*alt^2 ...
    + dat(row,6)*alt + dat(row,7));
    elseif alt <110
        row = 3;
        rho = exp(dat(row,3)*alt^4 + dat(row,4)*alt^3 + dat(row,5)*alt^2 ...
    + dat(row,6)*alt + dat(row,7));
    elseif alt < 120
        row = 4;
        rho = exp(dat(row,3)*alt^4 + dat(row,4)*alt^3 + dat(row,5)*alt^2 ...
    + dat(row,6)*alt + dat(row,7));
    elseif alt < 150
        row = 5
        rho = exp(dat(row,3)*alt^4 + dat(row,4)*alt^3 + dat(row,5)*alt^2 ...
    + dat(row,6)*alt + dat(row,7));
    elseif alt < 200
        row = 6
        rho = exp(dat(row,3)*alt^4 + dat(row,4)*alt^3 + dat(row,5)*alt^2 ...
    + dat(row,6)*alt + dat(row,7));
    elseif alt < 300
        row = 7
        rho = exp(dat(row,3)*alt^4 + dat(row,4)*alt^3 + dat(row,5)*alt^2 ...
    + dat(row,6)*alt + dat(row,7));
    elseif alt < 500 
        row = 8
        rho = exp(dat(row,3)*alt^4 + dat(row,4)*alt^3 + dat(row,5)*alt^2 ...
    + dat(row,6)*alt + dat(row,7));
    elseif alt < 750
        row = 9
        rho = exp(dat(row,3)*alt^4 + dat(row,4)*alt^3 + dat(row,5)*alt^2 ...
    + dat(row,6)*alt + dat(row,7));
    elseif alt <= 1000
        row = 10;
        rho = exp(dat(row,3)*alt^4 + dat(row,4)*alt^3 + dat(row,5)*alt^2 ...
    + dat(row,6)*alt + dat(row,7));
    else
        rho = 0;
    end
end
end