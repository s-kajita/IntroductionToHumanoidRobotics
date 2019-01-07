function InverseKinematicsAll(to, Target)
global uLINK

lambda = 0.9;
ForwardKinematics(1);
idx = FindRoute(to);
for n = 1:10
  J   = CalcJacobian(idx);
  err = CalcVWerr(Target, uLINK(to));
  if norm(err) < 1E-6 break, end;
  dq = lambda * (J \ err);
  MoveJoints(idx, dq);
  ForwardKinematics(1);
end

%--- Relative velocity with respect to the body
vd = Target.v - uLINK(1).v - cross(uLINK(1).w, Target.p - uLINK(1).p);
wd = Target.w - uLINK(1).w;
J  = CalcJacobian(idx);
vq = J \ [vd; wd];

for n=1:length(idx)
    j = idx(n);
    uLINK(j).dq = vq(n);
end
