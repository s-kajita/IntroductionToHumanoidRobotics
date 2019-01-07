function idx = FindRoute(to)
% return the list of joint number connecting ROOT to 'to'
global uLINK

i = uLINK(to).mother;
%if i == 0
%    idx = [];    % search failed
%    fprintf('FindRoute: search failed\n');
%else
if i == 1
    idx = [to];
else
    idx = [FindRoute(i) to];
%     idx2 = FindRoute(i);
%     if isempty(idx2) 
%         idx = [];
%     else
%         idx = [idx2 to];
%     end
end