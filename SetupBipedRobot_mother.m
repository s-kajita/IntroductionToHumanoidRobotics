%%% SetupBipedRobot2.m
%%% ２足歩行ロボット構造データ：図2.19，図2.20参照
%%% 各フィールドの定義は「表2.1　リンク情報」を参照のこと

global uLINK

ToDeg = 180/pi;
ToRad = pi/180;
UX = [1 0 0]';
UY = [0 1 0]';
UZ = [0 0 1]';

uLINK    = struct('name','BODY'    , 'm', 10, 'mother', 0, 'b',[0  0    0.7]','a',UZ,'q',0);

uLINK(2) = struct('name','RLEG_J0' , 'm',  5, 'mother', 1, 'b',[0 -0.1 0]',  'a',UZ,'q',0);
uLINK(3) = struct('name','RLEG_J1' , 'm',  1, 'mother', 2, 'b',[0  0   0]',  'a',UX,'q',0);
uLINK(4) = struct('name','RLEG_J2' , 'm',  5, 'mother', 3, 'b',[0  0   0]',  'a',UY,'q',0);
uLINK(5) = struct('name','RLEG_J3' , 'm',  1, 'mother', 4, 'b',[0  0  -0.3]','a',UY,'q',0);
uLINK(6) = struct('name','RLEG_J4' , 'm',  6, 'mother', 5, 'b',[0  0  -0.3]','a',UY,'q',0);
uLINK(7) = struct('name','RLEG_J5' , 'm',  2, 'mother', 6, 'b',[0  0   0  ]','a',UX,'q',0);

uLINK(8) = struct('name','LLEG_J0' , 'm',  5, 'mother', 1, 'b',[0  0.1 0]'   ,'a',UZ,'q',0);
uLINK(9) = struct('name','LLEG_J1' , 'm',  1, 'mother', 8, 'b',[0  0   0]','a',UX,'q',0);
uLINK(10)= struct('name','LLEG_J2' , 'm',  5, 'mother', 9, 'b',[0  0   0]'   ,'a',UY,'q',0);
uLINK(11)= struct('name','LLEG_J3' , 'm',  1, 'mother',10, 'b',[0  0  -0.3]' ,'a',UY,'q',0);
uLINK(12)= struct('name','LLEG_J4' , 'm',  6, 'mother',11, 'b',[0  0  -0.3]' ,'a',UY,'q',0);
uLINK(13)= struct('name','LLEG_J5' , 'm',  2, 'mother',12, 'b',[0  0   0  ]' ,'a',UX,'q',0);

[uLINK(1).vertex,uLINK(1).face]   = MakeBox([0.1 0.3 0.5]  ,[0.05 0.15 -0.05] );    % BODY
[uLINK(7).vertex,uLINK(7).face]   = MakeBox([0.2 0.1 0.02] ,[0.05  0.05 0.05]);     % Foot
[uLINK(13).vertex,uLINK(13).face] = MakeBox([0.2 0.1 0.02] ,[0.05  0.05 0.05]);     % Foot

FindChildren;   %　母リンクの情報をもとに娘、妹リンクを設定する

%%% プログラムを見やすくするため，リンクnameと同名の変数にID番号をセット
for n=1:length(uLINK)
    eval([uLINK(n).name,'=',num2str(n),';']);
end

uLINK(BODY).p = [0.0, 0.0, 0.65]';
uLINK(BODY).R = eye(3);
ForwardKinematics(1);