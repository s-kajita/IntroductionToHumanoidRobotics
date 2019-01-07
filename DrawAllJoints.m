function DrawAllJoints(j)
global uLINK
radius    = 0.02;
len       = 0.06;
joint_col = 0;

if j ~= 0  
    if ~isempty(uLINK(j).vertex)
        vert = uLINK(j).R * uLINK(j).vertex;
        for k = 1:3
            vert(k,:) = vert(k,:) + uLINK(j).p(k); % adding x,y,z to all vertex
        end
        DrawPolygon(vert, uLINK(j).face,0);
    end
    
    hold on
    
    i = uLINK(j).mother;
    if i ~= 0
        Connect3D(uLINK(i).p,uLINK(j).p,'k',2);
    end
    DrawCylinder(uLINK(j).p, uLINK(j).R * uLINK(j).a, radius,len, joint_col);
    
    
    DrawAllJoints(uLINK(j).child);
    DrawAllJoints(uLINK(j).sister);
end
