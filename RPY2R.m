function rot = RPY2R(rpy)

roll = rpy(1); pitch = rpy(2); yaw = rpy(3);
Cphi = cos(roll);  Sphi = sin(roll);
Cthe = cos(pitch); Sthe = sin(pitch);
Cpsi = cos(yaw);   Spsi = sin(yaw);

rot = [Cpsi*Cthe  -Spsi*Cphi+Cpsi*Sthe*Sphi  Spsi*Sphi+Cpsi*Sthe*Cphi;
       Spsi*Cthe  Cpsi*Cphi+Spsi*Sthe*Sphi   -Cpsi*Sphi+Spsi*Sthe*Cphi;
       -Sthe      Cthe*Sphi                  Cthe*Cphi                 ];
