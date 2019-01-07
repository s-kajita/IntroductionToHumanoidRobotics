function PrintLinkName(j)
global uLINK  % グローバル変数uLINKを参照する

if j ~= 0
    fprintf('j=%2d : %s\n',j,uLINK(j).name); % 自分の名前を表示
    PrintLinkName(uLINK(j).child);       % 娘の名前を表示
    PrintLinkName(uLINK(j).sister);      % 妹の名前を表示
end
