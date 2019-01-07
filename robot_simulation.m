%%%  robot_simulation.m
%%%  単位ベクトル法による動力学シミュレーション
%%%  注：床面との接触反力を計算していないので自由落下するだけです．
close all
clear

global uLINK G
G = 9.8;  % 重力加速度 [m/s^2]

SetupBipedRobot2;   % 図2.19，図2.20の2足歩行ロボットのデータを設定（重心位置，慣性テンソル付）

%%%%%% 胴体の空間速度・加速度 %%%%%
uLINK(BODY).vo = [0, 0, 0]';
uLINK(BODY).w  = [0, 0, 0]';

uLINK(BODY).dvo = [0, 0, 0]';
uLINK(BODY).dw  = [0, 0, 0]';

%%%%%%%　関節トルク %%%%%%%
u_joint = zeros(length(uLINK),1); % 全関節トルクを0に設定
u_joint(RLEG_J2) = -10.0;   % 右股関節ピッチ軸にトルクを与える　[Nm]

%%%%%%% シミュレーション %%%%%%%
global Dtime

Dtime = 0.005;
EndTime = 0.3;
time = 0:Dtime:EndTime;
tsize = length(time);
com_m = zeros(tsize,3);

figure
tic
for k = 1:tsize
    %fprintf('time=%f\n',time(n))
    ForwardDynamics; 
    
    IntegrateEuler(1);    
    com = calcCoM;
    com_m(k,:) = com';
    
    hold off
    newplot
    DrawAllJoints(1);
    axis equal
    set(gca,...
        'CameraPositionMode','manual',...
        'CameraPosition',[4,4,1],...
        'CameraViewAngleMode','manual',....
        'CameraViewAngle',15,...
        'Projection','perspective',... 
        'XLimMode','manual',...
        'XLim',[-0.5 0.5],...
        'YLimMode','manual',...
        'YLim',[-0.5 0.5],...
        'ZLimMode','manual',...
        'ZLim',[0 1.5])
    grid on
    text(0.5, -0.4, 1.4, ['time=',num2str(time(k),'%5.3f')])

    drawnow;
%    if k == 1
%      Mov = moviein(tsize);
%    end
%    Mov(:,k) = getframe;   
end        
toc
