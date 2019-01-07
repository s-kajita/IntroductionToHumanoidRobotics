function com = calcCoM()
global uLINK

M  = TotalMass(1);
MC = calcMC(1);
com = MC / M;