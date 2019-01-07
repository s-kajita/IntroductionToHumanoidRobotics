function P = calcP(j)
global uLINK

if j == 0
   P = [0 0 0]';
else
   c1 = uLINK(j).R * uLINK(j).c;
   P = uLINK(j).m * (uLINK(j).v + cross(uLINK(j).w, c1) );
   P = P + calcP(uLINK(j).sister) + calcP(uLINK(j).child);
end