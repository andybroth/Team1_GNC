function [phidot, zdot] = poincare_conditions(r, rdot, E, Hz)
    phidot = Hz/r^2;
    
    rho = r; 
    U = -(1/rho)+ 0.00108263/rho^3*(-1/2);
    zdot = sqrt(2*(E - U - Hz^2/(2*r^2)) - rdot^2);
end
