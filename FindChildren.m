num = length(uLINK);

for n=1:num
    uLINK(n).sister = 0;
    uLINK(n).child  = 0;
end

for n=1:num
    mom = uLINK(n).mother;  % My mother
    if mom ~= 0
        if uLINK(mom).child == 0
            uLINK(mom).child = n;  % I am the first child.
        else
            eldest_sister = uLINK(mom).child;  % I have a sister.
            SetYoungestSister(eldest_sister,n);
        end
    end
end