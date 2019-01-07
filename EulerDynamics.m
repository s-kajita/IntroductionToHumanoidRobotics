function L = EulerDynamics(j)
global uLINK
I = uLINK(j).R * uLINK(j).I * uLINK(j).R';    % Šµ«ƒeƒ“ƒ\ƒ‹
L = I * uLINK(j).w;                           % Šp‰^“®—Ê
uLINK(j).dw  = I \ (-cross(uLINK(j).w, L));   % Euler‚Ì•û’öŽ®