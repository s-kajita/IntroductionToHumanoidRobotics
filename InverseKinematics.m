function err_norm = InverseKinematics(to, Target)
global uLINK

lambda = 0.9;
idx = FindRoute(to);
ForwardKinematics(1);
err = CalcVWerr(Target, uLINK(to));
for n = 1:10
  if norm(err) < 1E-6 break, end;
  J  = CalcJacobian(idx);
  dq = lambda * (J \ err);
  MoveJoints(idx, dq);
  ForwardKinematics(1);
  err = CalcVWerr(Target, uLINK(to));
end

if nargout == 1 
    err_norm = norm(err);
end