% forward_velocity_ck.m
% 2013 Sept.23 s.kajita AIST

set(0,'DefaultTextInterpreter','none')

close all
clear              % claer work space
global uLINK       % allow access from external functions

SetupBipedRobot;   % Set the biped robot of Fig.2.19 and Fig.2.20

SkipFrame = 10;

%%%%%%%%%%% target foot position and orientation %%%%%%%%%%%%
idx   = FindRoute(RLEG_J5);
SetJointAngles(idx, [0 0 -25 50 -25 0]*ToRad);
Rfoot = uLINK(RLEG_J5);

Height = norm(uLINK(RLEG_J0).p - uLINK(RLEG_J5).p);
LegLength = 0.6;
SingularPoint = sqrt(0.6^2 - Height^2);

fprintf('*** Newton Raphson ***\n');

%xd_m = 0:0.005:0.4';
xd_m = 0:0.005:0.25;
Nstep = length(xd_m);
q_m = zeros(Nstep,6);
analy_q_m = zeros(Nstep,6);
x_m = zeros(Nstep,1);
manip_m = zeros(Nstep,1);
vx_m = zeros(Nstep,1);

vd = [1 0 0 0 0 0]';

figure
for n=1:Nstep
    Rfoot.p(1) = xd_m(n);  % Right foot
    
    rerr_norm = InverseKinematics(RLEG_J5, Rfoot);
    
    x_m(n) = uLINK(RLEG_J5).p(1);
    q_m(n,:) = [uLINK(idx).q];
    analy_q_m(n,:) = IK_leg(uLINK(BODY),-0.1,0.3,0.3,Rfoot)';      %%% Analytical inverse kinematics solution
    
    J = CalcJacobian(idx);
    qd = J \ vd;
    SetJointVelocities(idx, qd);
    ForwardVelocity(1);
    vx_m(n) = uLINK(RLEG_J5).v(1);
    
    manip_m(n) = abs(det(J));
    
    if mod(n,SkipFrame) == 1
        hold on
        DrawAllJoints(1);
        %view(38,10)
        view(141,20)
        axis equal
        xlim([-0.1 0.5])
        zlim([0 1.3])
        grid on
    end
    fprintf('ErrorÅF %8.3e \n',rerr_norm);
end
title([mfilename,' ',date])

figure;
h = plot(xd_m,ToDeg*q_m(:,[3 4 5]));
set(h,'LineWidth',2)
legend('RLEG_J2','RLEG_J3','RLEG_J4')
hold on;
plot(xd_m,ToDeg*analy_q_m(:,[3 4 5]),':')
plot(SingularPoint*[1 1],ylim,'m-.')
ylabel(' q [deg]')
xlabel(' x [m]')

figure
subplot(211)
plot(xd_m,x_m,xd_m,xd_m,'r--')
hold on;
plot(SingularPoint*[1 1],ylim,'m-.')
ylabel('x [m]')

subplot(212)
plot(xd_m,vx_m)
hold on;
plot(SingularPoint*[1 1],ylim,'m-.')
ylabel('vx[m/s]')
xlabel('xd [m]')

