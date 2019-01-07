function SetJointAnkles(idx, q)
global uLINK

for n=1:length(idx)
    j = idx(n);
    uLINK(j).q = q(n);
end
ForwardKinematics(1);