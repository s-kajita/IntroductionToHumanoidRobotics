function err = CalcVWerr(Cref, Cnow)
global uLINK

perr = Cref.p - Cnow.p;
Rerr = Cnow.R' * Cref.R;
werr = Cnow.R * rot2omega(Rerr);

err = [perr; werr];