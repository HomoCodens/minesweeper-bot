%records pixel positions of vertical and horizontal cell bounds
function [horLines, vertLines] = mineBounds(screen)
[m, n, ~] = size(screen);
horMid = ceil(n/2)-7;
vertMid = ceil(m/2)-7;

state = 0;
vertLines = [];
horLines = [];
i = 1;

while(i <= m)
    if(screen(i, horMid, 1) < 10 && state == 0)
        state = 1;
    elseif(state == 1)
        horLines(end+1) = i;
        i = i + 10;
        state = 0;
    end
    i = i + 1;
end

state = 0;
i = 1;

while(i <= n)
    if(screen(vertMid, i, 1) < 10 && state == 0)
        state = 1;
    elseif(state == 1)
        vertLines(end+1) = i;
        i = i + 10;
        state = 0;
    end
    i = i + 1;
end
end