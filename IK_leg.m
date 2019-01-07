function q = IK_leg(Body,D,A,B,Foot)

r = Foot.R' * (Body.p + Body.R * [0 D 0]'- Foot.p);  % ‘«Žñ‚©‚çŒ©‚½ŒÒŠÖß
C = norm(r);
c5 = (C^2-A^2-B^2)/(2.0*A*B);
if c5 >= 1 
    q5 = 0.0;
elseif c5 <= -1
    q5 = pi;
else
    q5 = acos(c5);  % knee pitch
end
q6a = asin((A/C)*sin(pi-q5));   % ankle pitch sub

q7 = atan2(r(2),r(3));  % ankle roll -pi/2 < q(6) < pi/2
if q7 > pi/2, q7=q7-pi; elseif q7 < -pi/2, q7=q7+pi; end
q6 = -atan2(r(1),sign(r(3))*sqrt(r(2)^2+r(3)^2)) -q6a; % ankle pitch

R = Body.R' * Foot.R * Rroll(-q7) * Rpitch(-q6-q5); %% hipZ*hipX*hipY
q2  = atan2(-R(1,2),R(2,2));   % hip yaw
cz = cos(q2); sz = sin(q2);
q3 = atan2(R(3,2),-R(1,2)*sz + R(2,2)*cz);  % hip roll
q4 = atan2( -R(3,1), R(3,3));               % hip pitch

q = [q2 q3 q4 q5 q6 q7]';
