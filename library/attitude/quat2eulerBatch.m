function eulerVec = quat2eulerBatch(quatVec)

N = size(quatVec,2);
eulerVec = zeros(3,N);
for ii = 1:N
   eulerVec(:,ii) = quat2euler(quatVec(:,ii));
end

end