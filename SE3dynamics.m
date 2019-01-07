function [P,L] = SE3dynamics(j,f,tau)
global uLINK

w_c = uLINK(j).R * uLINK(j).c + uLINK(j).p;   % center of mass
w_I = uLINK(j).R * uLINK(j).I * uLINK(j).R';  % inertia in world frame
c_hat = hat(w_c);
Iww = w_I + uLINK(j).m * c_hat * c_hat';    
Ivv = uLINK(j).m * eye(3);
Iwv = uLINK(j).m * c_hat;

P = uLINK(j).m * (uLINK(j).vo + cross(uLINK(j).w,w_c));     % linear  momentum
L = uLINK(j).m * cross(w_c,uLINK(j).vo) + Iww * uLINK(j).w; % angular momentum

pp = [cross(uLINK(j).w,P);
    cross(uLINK(j).vo,P) + cross(uLINK(j).w,L)];
if nargin == 3
    pp = pp - [f; tau];   % 外力，外モーメントを加算
end
Ia = [Ivv, Iwv'; Iwv, Iww];

a0 = -Ia \ pp;
uLINK(j).dvo = a0(1:3);
uLINK(j).dw  = a0(4:6);
