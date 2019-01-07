function [f,t] = InverseDynamics(j)
global uLINK

if j == 0
    f=[0,0,0]';
    t=[0,0,0]';
    return; 
end

c = uLINK(j).R * uLINK(j).c + uLINK(j).p;   % center of mass
I = uLINK(j).R * uLINK(j).I * uLINK(j).R';  % inertia in world frame
c_hat = hat(c);
I = I + uLINK(j).m * c_hat * c_hat'; 

P = uLINK(j).m * (uLINK(j).vo + cross(uLINK(j).w,c));   % linear  momentum
L = uLINK(j).m * cross(c,uLINK(j).vo) + I * uLINK(j).w; % angular momentum

f0 = uLINK(j).m * (uLINK(j).dvo + cross(uLINK(j).dw,c))   + cross(uLINK(j).w,P);
t0 = uLINK(j).m * cross(c,uLINK(j).dvo) + I * uLINK(j).dw + cross(uLINK(j).vo,P) + cross(uLINK(j).w,L);

% from child link
[f1,t1] = InverseDynamics(uLINK(j).child);
f = f0 + f1;
t = t0 + t1;
if j ~= 1
    uLINK(j).u = uLINK(j).hv' * f + uLINK(j).hw' * t;  % joint driving force
end

% return force to mother, with sisters
[f2,t2] = InverseDynamics(uLINK(j).sister);
f = f + f2;
t = t + t2;