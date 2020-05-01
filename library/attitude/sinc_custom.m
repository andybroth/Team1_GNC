function y = sinc_custom(x)
% this implements custom sinc function

i=find(x==0);                                                              
x(i)= 1;               
y = sin(x)./(x);                                                     
y(i) = 1;   

end


