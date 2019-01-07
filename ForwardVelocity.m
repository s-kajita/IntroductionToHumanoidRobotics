function ForwardVelocity(j)
% 2013 Sep.23 Bug fixed thanks to Rafael Cisneros.

global uLINK

if j == 0 return; end
if j ~= 1
    mom = uLINK(j).mother;
    uLINK(j).v = uLINK(mom).v + cross(uLINK(mom).w, uLINK(mom).R * uLINK(j).b);
    uLINK(j).w = uLINK(mom).w + uLINK(mom).R * (uLINK(j).a * uLINK(j).dq);
end
ForwardVelocity(uLINK(j).sister);
ForwardVelocity(uLINK(j).child);
