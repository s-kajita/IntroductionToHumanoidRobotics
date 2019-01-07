function [f,t] = TopForce(j)
global uLINK G
w_c = uLINK(j).R * uLINK(j).c + uLINK(j).p;   % 重心位置
f = [0 0 -uLINK(j).m * G]';    % 重力
t = cross(w_c, f);            % 重力による原点回りモーメント

if uLINK(j).p(3) < 0.0  % 支点は床面と接触している
    Kf = 1.0E+4;        % 床面の剛性[N/m]
    Df = 1.0E+3;        % 床面の粘性[N/(m/s)]
    v = uLINK(j).vo + cross(uLINK(j).w,uLINK(j).p);  % 支点の速度
    fc = [-Df*v(1)  -Df*v(2) -Kf*uLINK(j).p(3)-Df*v(3)]';
    f = f + fc;
    t = t + cross(uLINK(j).p, fc);
end
