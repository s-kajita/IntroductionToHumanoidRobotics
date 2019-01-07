global uLINK
lx  = 0.1; ly  = 0.4; lz  = 0.9;         % 縦，横，高さ [m]
mass = 36.0;                             % 質量 [kg]
MakeRigidBody(1, [lx ly lz], mass);      % 直方体のデータを作成

uLINK(1).p = [0.0, 0.0, 0]'; % 初期位置 [m]
uLINK(1).R = eye(3);         % 初期姿勢
uLINK(1).w = [1, 1, 1]';     % 初期角速度 [rad/s]
Dtime   = 0.02;           % 積分ステップ [s]
EndTime = 5.0;            % 終了時刻 [s]
time  = 0:Dtime:EndTime;
figure
AX=[-0.5 0.5]; AY=[-0.5 0.5]; AZ=[-0.5 1.0]; % 3D表示範囲
for n = 1:length(time)
    L = EulerDynamics(1);    % Eulerの運動方程式
    uLINK(1).R = Rodrigues(uLINK(1).w, Dtime) * uLINK(1).R; % Rodrigues
    uLINK(1).w = uLINK(1).w + Dtime * uLINK(1).dw;          % Euler法
    ShowObject;                 %  物体を描画する
end        