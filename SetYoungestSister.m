function SetYoungestSister(sis,n)
global uLINK

if uLINK(sis).sister == 0
    uLINK(sis).sister = n;  % I am your sister.
else
    SetLastSister(uLINK(sis).sister, n); % Other sisters?
end
