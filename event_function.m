function [position,isterminal, direction] = event_function(t,r)
%Event function for reaching the ascending node
hw1a;

position = r(3);
isterminal = 0;
direction = 1;
end

