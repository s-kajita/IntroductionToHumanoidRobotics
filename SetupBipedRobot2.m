%%% SetupBipedRobot2.m
%%% ２足歩行ロボット構造データ：図2.19，図2.20参照
%%% 各フィールドの定義は「表2.1　リンク情報」を参照のこと

ToDeg = 180/pi;
ToRad = pi/180;
UX = [1 0 0]';
UY = [0 1 0]';
UZ = [0 0 1]';

uLINK    = struct('name','BODY'    , 'm', 10, 'sister', 0, 'child', 2, 'b',[0  0    0.7]','a',UZ,'q',0);

uLINK(2) = struct('name','RLEG_J0' , 'm',  5, 'sister', 8, 'child', 3, 'b',[0 -0.1 0]'   ,'a',UZ,'q',0);
uLINK(3) = struct('name','RLEG_J1' , 'm',  1, 'sister', 0, 'child', 4, 'b',[0  0   0]','a',UX,'q',0);
uLINK(4) = struct('name','RLEG_J2' , 'm',  5, 'sister', 0, 'child', 5, 'b',[0  0   0]'   ,'a',UY,'q',0);
uLINK(5) = struct('name','RLEG_J3' , 'm',  1, 'sister', 0, 'child', 6, 'b',[0  0  -0.3]' ,'a',UY,'q',0);
uLINK(6) = struct('name','RLEG_J4' , 'm',  6, 'sister', 0, 'child', 7, 'b',[0  0  -0.3]' ,'a',UY,'q',0);
uLINK(7) = struct('name','RLEG_J5' , 'm',  2, 'sister', 0, 'child', 0, 'b',[0  0   0  ]' ,'a',UX,'q',0);

uLINK(8) = struct('name','LLEG_J0' , 'm',  5, 'sister', 0, 'child', 9, 'b',[0  0.1 0]'   ,'a',UZ,'q',0);
uLINK(9) = struct('name','LLEG_J1' , 'm',  1, 'sister', 0, 'child',10, 'b',[0  0   0]','a',UX,'q',0);
uLINK(10)= struct('name','LLEG_J2' , 'm',  5, 'sister', 0, 'child',11, 'b',[0  0   0]'   ,'a',UY,'q',0);
uLINK(11)= struct('name','LLEG_J3' , 'm',  1, 'sister', 0, 'child',12, 'b',[0  0  -0.3]' ,'a',UY,'q',0);
uLINK(12)= struct('name','LLEG_J4' , 'm',  6, 'sister', 0, 'child',13, 'b',[0  0  -0.3]' ,'a',UY,'q',0);
uLINK(13)= struct('name','LLEG_J5' , 'm',  2, 'sister', 0, 'child', 0, 'b',[0  0   0  ]' ,'a',UX,'q',0);

FindMother(1);   %　妹，娘リンクの情報をもとに母リンクを設定する

%% フィールドの追加
for n=1:length(uLINK)
    uLINK(n).dq     = 0;            % 関節速度   [rad/s]
    uLINK(n).ddq    = 0;            % 関節加速度 [rad/s^2]
    uLINK(n).c      = [0 0 0]';     % 重心位置   [m]
    uLINK(n).I      = zeros(3,3);   % 重心回りの慣性テンソル [kg.m^2]
    uLINK(n).Ir     = 0.0;          % モータの電気子慣性モーメント [kg.m^2]
    uLINK(n).gr     = 0.0;          % モータの減速比 [-]
    uLINK(n).u      = 0.0;          %  関節トルク [Nm]
end

%%% プログラムを見やすくするため，リンクnameと同名の変数にID番号をセット
for n=1:length(uLINK)
    eval([uLINK(n).name,'=',num2str(n),';']);
end

%%%%%%%%%　胴体，および足部を剛体でモデル化 %%%%%%%%%
shape = [0.1 0.3 0.5];     % 奥行き，幅，高さ [m]
com   = [0 0 0.3]';        % 重心位置
SetupRigidBody(BODY, shape,com);

shape = [0.2 0.1 0.02];    % 奥行き，幅，高さ [m]
com   = [0.05  0 -0.04]';   % 重心位置
SetupRigidBody(RLEG_J5, shape,com);

shape = [0.2 0.1 0.02];     % 奥行き，幅，高さ [m]
com   = [0.05  0 -0.04]';    % 重心位置
SetupRigidBody(LLEG_J5, shape,com);

%%%%%%%%%%% 非特異姿勢へ移行　%%%%%%%%%%%%
uLINK(RLEG_J2).q = -10.0*ToRad;
uLINK(RLEG_J3).q = 20.0*ToRad;
uLINK(RLEG_J4).q = -10.0*ToRad;

uLINK(LLEG_J2).q = -10.0*ToRad;
uLINK(LLEG_J3).q = 20.0*ToRad;
uLINK(LLEG_J4).q = -10.0*ToRad;

uLINK(BODY).p = [0.0, 0.0, 0.7]';
uLINK(BODY).R = eye(3);

ForwardKinematics(1);