function R = Ryaw(psi)

c = cos(psi); s = sin(psi);
R = [c -s 0; s c 0; 0 0 1];