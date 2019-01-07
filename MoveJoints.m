function MoveJoints(idx, dq)
global uLINK

for n=1:length(idx)
    j = idx(n);
    uLINK(j).q = uLINK(j).q + dq(n);
end
