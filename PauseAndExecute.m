function PauseAndExecute(instruction,comment)
global uLINK

fprintf('>> %s  %% %s\n',instruction,comment)
fprintf('      (hit any key to continue)\n')
pause
eval(instruction);