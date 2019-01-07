function h = DrawMarker(pos,col)
d = 0.2;
hold on
plot3([pos(1)-d pos(1)+d],[pos(2) pos(2)],[pos(3) pos(3)],col);
plot3([pos(1) pos(1)]    ,[pos(2)-d pos(2)+d],[pos(3) pos(3)],col);
h = plot3([pos(1) pos(1)],[pos(2) pos(2)],[pos(3) pos(3)+d],col);
