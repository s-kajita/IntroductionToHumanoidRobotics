function L = calcL(j)
global uLINK

if j == 0
   L = 0;
else
   c1 = uLINK(j).R * uLINK(j).c;
   c  = uLINK(j).p + c1;
   P = uLINK(j).m * (uLINK(j).v + cross(uLINK(j).w , c1));
   L = cross(c, P) + uLINK(j).R * uLINK(j).I * uLINK(j).R' * uLINK(j).w;
   L = L + calcL(uLINK(j).sister) + calcL(uLINK(j).child);
end