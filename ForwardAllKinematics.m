function ForwardAllKinematics(j)
global uLINK G

if j == 0 return; end
if j ~= 1
    mom = uLINK(j).mother;
    % position and orientation
    uLINK(j).p = uLINK(mom).R * uLINK(j).b + uLINK(mom).p;
    uLINK(j).R = uLINK(mom).R * Rodrigues(uLINK(j).a, uLINK(j).q);
    
    % spatial velocity
    hw = uLINK(mom).R * uLINK(j).a;  % axis vector in world frame
    hv = cross(uLINK(j).p, hw);      % p_i x axis
    
    uLINK(j).hw = hw;                % store h1 and h2 for future use
    uLINK(j).hv = hv;
    
    uLINK(j).w  = uLINK(mom).w  + hw * uLINK(j).dq;
    uLINK(j).vo = uLINK(mom).vo + hv * uLINK(j).dq; 
    
    % spatial acceleration
    dhv = cross(uLINK(mom).w, hv) + cross(uLINK(mom).vo, hw);
    dhw = cross(uLINK(mom).w, hw);
    
    uLINK(j).dw  = uLINK(mom).dw  + dhw * uLINK(j).dq + hw * uLINK(j).ddq;
    uLINK(j).dvo = uLINK(mom).dvo + dhv * uLINK(j).dq + hv * uLINK(j).ddq;  
end

ForwardAllKinematics(uLINK(j).sister);
ForwardAllKinematics(uLINK(j).child);
