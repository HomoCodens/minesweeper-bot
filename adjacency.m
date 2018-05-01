%Counts the number of unknown/mined cells adjacent to (i, j)
function [nBomb, nVeiled] = adjacency(board, i, j)
[m, n] = size(board);
nBomb = 0;
nVeiled = 0;
for k = i-1:i+1
    if(k > 0 && k <= m)
        for l = j-1:j+1
            if(l > 0 && l <= n && ~all([k, l] == [i, j]))
                if(board(k, l) == 9 || board(k, l) == 10)
                    nBomb = nBomb + 1;
                elseif(board(k, l) == -1)
                    nVeiled = nVeiled + 1;
                end
            end
        end
    end
end