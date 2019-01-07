function SetupRigidBody(j,shape,com)
% shape: dimension [x y z], org: origin [x0 y0 z0]
global uLINK

vert = [
   0      0      0;
   0      shape(2) 0;
   shape(1) shape(2) 0;
   shape(1) 0      0;
   0      0      shape(3);
   0      shape(2) shape(3);
   shape(1) shape(2) shape(3);
   shape(1) 0      shape(3);
]';

% Let the origin [0;0;0] be the box center 
vert(1,:) = vert(1,:) -shape(1)/2 + com(1);
vert(2,:) = vert(2,:) -shape(2)/2 + com(2);
vert(3,:) = vert(3,:) -shape(3)/2 + com(3);

face = [
   1 2 3 4;
   2 6 7 3;
   4 3 7 8;
   1 5 8 4;
   1 2 6 5;
   5 6 7 8;
]';

uLINK(j).vertex = vert;
uLINK(j).face   = face;
uLINK(j).c      = com;
uLINK(j).I = [1/12*(shape(2)^2 + shape(3)^2) 0 0;...
            0 1/12*(shape(1)^2 + shape(3)^2)  0;...
            0 0 1/12*(shape(1)^2 + shape(2)^2)] * uLINK(j).m;  % Inertia tensor
