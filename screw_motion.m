%%%  forward dynamics by unit vector method
clear
close all

global uLINK G
ToRad = pi/180;
G = 9.8;

WAIST = 1;
uLINK = struct('name','BODY'    , 'm', 10, 'sister', 0, 'child', 0, 'b',[0  0  0]','a',[0 0 1]','q',0);
uLINK.mother = 0;

% Inertia tensor
lx  = 0.1;
ly  = 0.4;
lz  = 0.9;
[uLINK(1).vertex,uLINK(1).face]   = MakeBox([lx ly lz]  ,[lx/2 ly/2 lz/2] );    % BODY

%%%%%%%%%%%%%%%%%%

%% body state
uLINK(WAIST).p = [0, 0, 0]';
uLINK(WAIST).R = eye(3);

uLINK(WAIST).w  = [1, 0, 0]';
uLINK(WAIST).vo = [0.3 0 1]';

for n=1:length(uLINK)
    uLINK(n).u = 0.0;
end

global Dtime

Dtime = 0.3;
time  = 0:Dtime:10.0;
tsize = length(time);

figure
for n = 1:tsize
    DrawAllJoints(1);
    [uLINK.p, uLINK.R] = SE3exp(1, Dtime);       
end
view(3)
axis equal
grid on
xlabel('x')
ylabel('y')
zlabel('z')