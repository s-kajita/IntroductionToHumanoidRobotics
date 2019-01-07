% 順運動学のデモ　ランダムな姿勢を表示
% fk_random.m
% 2004 Dec.17 s.kajita AIST

close all
clear              % 作業領域のメモリを初期化
global uLINK       % グローバル変数として，外部関数からの参照を可能にする

SetupBipedRobot;   % 図2.19，図2.20の2足歩行ロボットのデータを設定

%%%%%%%%%%% ランダムな姿勢　%%%%%%%%%%%%

rand('state',0);  %乱数初期状態

figure
while 1
    qR1 = 2/3*pi*(rand(6,1)-0.5);  %  -pi/2 < q < pi/2
    qR1(4) = pi*rand;          %   0 < q4 < pi 
    
    qL1 = pi*(rand(6,1)-0.5);  %  -pi/2 < q < pi/2
    qL1(4) = pi*rand;          %   0 < q4 < pi 
    
    for n=0:5
        uLINK(RLEG_J0+n).q = qR1(n+1);
        uLINK(LLEG_J0+n).q = qL1(n+1);
    end
    
    uLINK(BODY).p = [0.0, 0.0, 0.7]';
    uLINK(BODY).R = eye(3);
    ForwardKinematics(1);
    
    clf
    DrawAllJoints(1);
    view(38,14)
    axis equal
    zlim([0.1 1.3])
    grid on
    
    fprintf('Ctrl-C:終了, それ以外：別の姿勢を表示\n');
    pause
end
