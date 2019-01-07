function mc = calcMC(j)
global uLINK

if j == 0
    mc = 0;
else
    mc = uLINK(j).m * (uLINK(j).p + uLINK(j).R * uLINK(j).c);
    mc = mc + calcMC(uLINK(j).sister) + calcMC(uLINK(j).child);
end
