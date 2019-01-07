function rot = rpy2rot(roll,pitch,yaw)

Cphi = cos(roll);  Sphi = sin(roll);
Cthe = cos(pitch); Sthe = sin(pitch);
Cpsi = cos(yaw);   Spsi = sin(yaw);

rot = [Cpsi*Cthe  -Spsi*Cphi+Cpsi*Sthe*Sphi  Spsi*Sphi+Cpsi*Sthe*Cphi;
       Spsi*Cthe  Cpsi*Cphi+Spsi*Sthe*Sphi   -Cpsi*Sphi+Spsi*Sthe*Cphi;
       -Sthe      Cthe*Sphi                  Cthe*Cphi                 ];
