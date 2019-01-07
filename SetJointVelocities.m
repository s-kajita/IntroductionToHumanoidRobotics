function SetJointVelocities(idx, dq)
global uLINK

for n=1:length(idx)
    j = idx(n);
    uLINK(j).dq = dq(n);
end
