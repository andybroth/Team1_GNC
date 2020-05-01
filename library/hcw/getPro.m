function x0 = getPro(n,r_in,r_out,ang_vec,offset)
% Purpose:
%   This function provides relative initial orbit that puts two spacecraft
%   into PRO, assuming HCW dynamics. For a same r_in, r_out, and offset,
%   different ang_vec will give same PRO with a same ellitical orbit with
%   phase shift.  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = length(ang_vec);
x = [0, offset+2*r_in,  0, r_in*n, 0, r_out*n]';
x0 = zeros(6,N);
T = 2*pi/n;
for ii = 1:N
    dt = ang_vec(ii)/2*pi*T;
    x0(:,ii) = hcw_sol(n,dt,x);
end

end