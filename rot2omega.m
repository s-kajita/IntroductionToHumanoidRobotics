function w = rot2omega(R)
% T.Sugihara "Solvability-unconcerned Inverse Kinemacics based on 
% Levenberg-Marquardt method with Robust Damping," Humanoids 2009

el = [R(3,2)-R(2,3); R(1,3)-R(3,1); R(2,1)-R(1,2)];
norm_el = norm(el);
if norm_el > eps
    w = atan2(norm_el, trace(R)-1)/norm_el * el;
elseif R(1,1)>0 && R(2,2)>0 && R(3,3)>0
    w = [0 0 0]';
else
    w = pi/2*[R(1,1)+1; R(2,2)+1; R(3,3)+1];
end
