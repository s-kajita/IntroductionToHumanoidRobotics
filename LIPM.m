function [px,vx] = LIPM(t,org,x0,Tc)

px = (x0-org) * cosh(t/Tc) + org;
vx = (x0-org)/Tc * sinh(t/Tc);