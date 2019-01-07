%%%  simplest simulation of rigid body rotation and translation
close all
clear
global uLINK
uLINK = struct('name','BODY' , 'sister', 0, 'child', 0, 'b',[0  0  0]','a',[0 0 1]','mother',0);

% geometry
lx  = 0.1;
ly  = 0.4;
lz  = 0.9;
[uLINK.vertex,uLINK.face] = MakeBox([lx ly lz]  ,[lx/2 ly/2 lz/2] );
uLINK.m = 36.0;
uLINK.I = [ 1/12*(ly^2 + lz^2) 0 0;
            0 1/12*(lx^2 + lz^2)  0;
            0 0 1/12*(lx^2 + ly^2)] * uLINK.m;
uLINK.c = [0 0 0]';
        
%% initial state
uLINK.p = [0.0, 0.0, 0.0]';
uLINK.R = eye(3);
uLINK.w = [1 0 1]';
uLINK.vo= [0.5 0.1 0]';

Dtime   = 0.005;
EndTime = 5.0;
time  = 0:Dtime:EndTime;
tsize = length(time);
frame_skip = 60;

L_m = zeros(tsize,3);
P_m = zeros(tsize,3);
w_m = zeros(tsize,3);
vo_m = zeros(tsize,3);

figure
for n = 1:tsize
    vo_m(n,:) = uLINK(1).vo';
    
    [P,L] = SE3dynamics(1);
    P_m(n,:) = P';
    L_m(n,:) = L';
    
    [uLINK.p, uLINK.R] = SE3exp(1, Dtime);       
    uLINK(1).w = uLINK(1).w + Dtime * uLINK(1).dw;
    uLINK(1).vo= uLINK(1).vo+ Dtime * uLINK(1).dvo;
        
    if mod(n,frame_skip) == 1
        DrawAllJoints(1)
    end
end        
view(3)
axis equal
grid on
xlabel('x')
ylabel('y')
zlabel('z')

figure
subplot(211)
h = plot(time,vo_m);
setLineProperty(h)
legend('vo_x','vo_y','vo_z')
ylabel('vo [m/s]')

subplot(212)
h = plot(time,P_m);
setLineProperty(h)
legend('Px','Py','Pz')
ylabel('P [Ns]')
xlabel('time [s]')