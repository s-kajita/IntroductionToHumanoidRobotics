function [p2, R2] = SE3exp(j, dt)
global uLINK
% see Murray, Li, Sastry p.42

norm_w = norm(uLINK(j).w);
if norm_w < eps
    p2 = uLINK(j).p + dt * uLINK(j).vo;
    R2 = uLINK(j).R;
else
    th = norm_w*dt;
    wn = uLINK(j).w/norm_w;		% normarized vector
    vo = uLINK(j).vo/norm_w;
    
    w_wedge = [0 -wn(3) wn(2);wn(3) 0 -wn(1);-wn(2) wn(1) 0];
    drot = w_wedge * sin(th) + w_wedge^2 * (1-cos(th));
    rot  = eye(3) + drot;
    
    p2 = rot * uLINK(j).p -drot*cross(wn, vo) + wn * wn' * vo * th;   
    R2 = rot * uLINK(j).R;
end
