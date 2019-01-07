% Analytical inverse kinematics with random target
% fk_random.m
% 2004 Dec.17 s.kajita AIST

close all
clear              % clear work space
global uLINK       % allow access from external functions

SetupBipedRobot;   % Set the biped robot of Fig.2.19 and Fig.2.20

%%%%%%%%%%% set non singular posture %%%%%%%%%%%%
uLINK(RLEG_J2).q = -10.0*ToRad;
uLINK(RLEG_J3).q = 20.0*ToRad;
uLINK(RLEG_J4).q = -10.0*ToRad;

uLINK(LLEG_J2).q = -10.0*ToRad;
uLINK(LLEG_J3).q = 20.0*ToRad;
uLINK(LLEG_J4).q = -10.0*ToRad;

uLINK(BODY).p = [0.0, 0.0, 0.7]';
uLINK(BODY).R = eye(3);

%%%%%%%%%%% random target foot position and orientation %%%%%%%%%%%%

rand('state',0);

figure
while 1
    uLINK(BODY).p = [0.0, 0.0, 0.5]';
    uLINK(BODY).R = eye(3);

    Rfoot.p = [0, -0.1, 0]' + 0.2*(rand(3,1)-0.5);
    Rfoot.R = RPY2R(1/2*pi*(rand(3,1)-0.5));  %  -pi/4 < q < pi/4

    Lfoot.p = [0, 0.1, 0]' + 0.1*(rand(3,1)-0.5);
    Lfoot.R = RPY2R(1/2*pi*(rand(3,1)-0.5)); %  -pi/4 < q < pi/4

    %%% Analytical inverse kinematics solution
    qR2 = IK_leg(uLINK(BODY),-0.1,0.3,0.3,Rfoot);
    qL2 = IK_leg(uLINK(BODY), 0.1,0.3,0.3,Lfoot);

    for n=0:5
        uLINK(RLEG_J0+n).q = qR2(n+1);
        uLINK(LLEG_J0+n).q = qL2(n+1);
    end

    ForwardKinematics(1);
    
    clf
    DrawAllJoints(1);
    view(38,10)
    axis equal
    zlim([-0.2 1.2])
    grid on

    fprintf('Type any key for another pose, Ctrl-C to abort\n');
    pause
end
