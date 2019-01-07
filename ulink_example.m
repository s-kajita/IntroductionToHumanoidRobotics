% ulink_example.m
% 2.4.2 Programming with Recursions

clear              % clear workspace
global uLINK       % allow access from the external functions

%%% set the properties of uLINK struct, name, sister, child, m(mass) %%%
uLINK    = struct('name','BODY' , 'sister', 0, 'child', 2, 'm', 10);
uLINK(2) = struct('name','RARM' , 'sister', 4, 'child', 3, 'm',  5);
uLINK(3) = struct('name','RHAND', 'sister', 0, 'child', 0, 'm',  1);
uLINK(4) = struct('name','LARM' , 'sister', 6, 'child', 5, 'm',  5);
uLINK(5) = struct('name','LHAND', 'sister', 0, 'child', 0, 'm',  1);
uLINK(6) = struct('name','RLEG' , 'sister', 8, 'child', 7, 'm',  6);
uLINK(7) = struct('name','RFOOT', 'sister', 0, 'child', 0, 'm',  2);
uLINK(8) = struct('name','LLEG' , 'sister', 0, 'child', 9, 'm',  6);
uLINK(9) = struct('name','LFOOT', 'sister', 0, 'child', 0, 'm',  2);

fprintf('[[[[[ uLINK struct was set as following ]]]]]\n')
fprintf('-------------------------------------\n');
fprintf('ID     name    sister child   mass\n');
fprintf('-------------------------------------\n');
for n=1:length(uLINK)
    fprintf('%d  %8s     %2d    %2d    %7.2f\n',n,uLINK(n).name,uLINK(n).sister,uLINK(n).child,uLINK(n).m);
end
fprintf('\n');

%%% データの呼び出し
PauseAndExecute('uLINK(1).name','the name of the link with ID=1')
PauseAndExecute('uLINK(uLINK(1).child).name','the name of the child')
PauseAndExecute('uLINK(uLINK(uLINK(1).child).child).name','the name of the grandchild')

PauseAndExecute('PrintLinkName(1)','show the name of all links')
PauseAndExecute('TotalMass(1)','sum of the mass of all link')