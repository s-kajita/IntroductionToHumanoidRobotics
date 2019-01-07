function R = Rodrigues(w,dt)
% w should be a vector of size 3

norm_w = norm(w);
if norm_w < eps
    R = eye(3);
else
    wn = w/norm_w;   % rotation axis (unit vector)
    th = norm_w*dt;  % amount of rotation (rad)
    w_wedge = [0 -wn(3) wn(2);wn(3) 0 -wn(1);-wn(2) wn(1) 0];
    R = eye(3) + w_wedge * sin(th) + w_wedge^2 * (1-cos(th));
end
