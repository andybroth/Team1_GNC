%% Compute the state of the deputy in LHLV frame
% INPUT: mean motion of the chief (n), Time from the reference(t-t0)
% OUTPUT: State transition matrix
% ref: Chapter 5(Formation Flying) Eqn 5.16
function expA_state = exppA_state(n, time)
snt = sin(n*time);
cnt = cos(n*time);
expA_state = [  4-3*cnt, 0, 0, snt/n, 2/n-2*cnt/n, 0;
                -6*n*time+6*snt, 1, 0, -2/n+2*cnt/n, 4*snt/n-3*time, 0;
                0, 0, cnt, 0, 0, snt/n;
                3*n*snt, 0, 0, cnt, 2*snt, 0;
                -6*n+6*n*cnt, 0, 0, -2*snt, -3+4*cnt, 0;
                0, 0, -n*snt, 0, 0, cnt];
end
