function [px,py] = calcZMP(c,dP,dL,pz)
global M G 

px = (M*G*c(1) + pz * dP(1) - dL(2))/(M*G + dP(3));
py = (M*G*c(2) + pz * dP(2) + dL(1))/(M*G + dP(3));