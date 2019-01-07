function IntegrateEuler(j)
% following Featherstone "Robot Dynamics Algorithm" p.103
% '04 May 8 s.k AIST  
global uLINK Dtime

if j == 0 return; end
if j == 1
    [uLINK(j).p, uLINK(j).R] = SE3exp(j, Dtime);    
    uLINK(j).vo = uLINK(j).vo + Dtime * uLINK(j).dvo;
    uLINK(j).w  = uLINK(j).w  + Dtime * uLINK(j).dw;    
    %IntegrateSE3(j, Dtime);
else
    uLINK(j).q  = uLINK(j).q  + Dtime * uLINK(j).dq;
    uLINK(j).dq = uLINK(j).dq + Dtime * uLINK(j).ddq;
end

IntegrateEuler(uLINK(j).sister);
IntegrateEuler(uLINK(j).child);
