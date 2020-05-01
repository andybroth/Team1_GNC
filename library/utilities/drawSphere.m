function [] = drawSphere(radius)
%Draws the Earth
[X,Y,Z] = sphere;
surf(X*radius, Y*radius, Z*radius)
axis equal
end

