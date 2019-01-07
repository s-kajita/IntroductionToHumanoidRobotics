function MakeTop(j, r,a,c)
global uLINK

[vertex1,face1] = MakeZcylinder([0 0 c]',r,a);       % 円盤部の形状
[vertex2,face2] = MakeZcylinder([0 0 c]',0.01,2*c);  % 軸の形状
uLINK(j).vertex = [vertex1 vertex2];
face2 = face2 + size(vertex1,2);
uLINK(j).face   = [face1 face2];

density = 2.7E+3;                      % アルミニウムの比重　[kg/m^2]
uLINK(j).m = pi*r^2*a*density;         % 円盤部の質量 [kg]
uLINK(j).I = [ (a^2 + 3*r^2)/12 0 0;   
               0 (a^2 + 3*r^2)/12  0;
               0 0 r^2/2] * uLINK(j).m;   % 円盤部の慣性テンソル
uLINK(j).c = [0 0 c]';                 % 重心
