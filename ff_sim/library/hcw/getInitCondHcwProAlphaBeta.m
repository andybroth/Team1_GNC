function [x0] = getInitCondHcwProAlphaBeta(n,A0,B0,alpha,beta,yoff)

x0 = [    A0*cos(alpha);
       -2*A0*sin(alpha)+yoff;
          B0*cos(beta);
       -n*A0*sin(alpha);
     -2*n*A0*cos(alpha);
       -n*B0*sin(beta)];


end

