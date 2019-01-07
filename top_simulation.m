% top_simulation.m
% コマの運動のシミュレーション
clear
close all
global uLINK G
G = 9.8;
r = 0.2; a = 0.05; c = 0.2;           % 円盤の半径,厚み，軸の長さ/2 [m]
MakeTop(1, r,a,c);

uLINK(1).p = [0 0 0.3]';                 % 初期位置 [m]
uLINK(1).R = Rodrigues([1 0 0],pi/50);   % 初期姿勢
uLINK(1).vo= [0 0 0]';                   % 初速度 [m/s]
uLINK(1).w = [0 0 50]';                  % 初期角速度 [rad/s]
Dtime   = 0.002;
EndTime = 2.0;
time  = 0:Dtime:EndTime;
frame_skip = 3;
figure
AX=[-0.2 0.4];  AY=[-0.3 0.3]; AZ=[0 0.8];  % 3D表示範囲
for n = 1:length(time)
    [f,tau] = TopForce(1);                           % 外力の計算
    [P,L]   = SE3dynamics(1,f,tau);                  % 加速度の計算    
    [uLINK(1).p, uLINK(1).R] = SE3exp(1, Dtime);           % 位置・姿勢の更新       
    uLINK(1).w = uLINK(1).w + Dtime * uLINK(1).dw;   % 角速度の更新
    uLINK(1).vo= uLINK(1).vo+ Dtime * uLINK(1).dvo;  % 速度の更新
    if mod(n,frame_skip) == 0
         ShowObject;                                 % 表示
    end
end
