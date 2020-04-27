function quat = quatRandom(varargin)

if nargin == 0
    n = 1;
elseif nargin == 1
    n = varargin{1};
else
    error('accepts only one input with real integer values');
end

euler = [rand(1,n)*2*pi-pi;
         rand(1,n)*pi-pi/2;
         rand(1,n)*pi-pi/2];

     
quat = zeros(4,n);
for ii = 1:n
    quat(:,ii) = euler2quat321(euler(:,ii));
end


end