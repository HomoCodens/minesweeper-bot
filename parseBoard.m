function board = parseBoard(screen, horLines, vertLines, board)
% board values
% -2 - guessed at on previous turn, treat as water
% -1 - unrevealed
% 0 - nothing
% 1 - 1 adjacent
% 2 - 2 adjacent
% 3 - 3 adjacent
% ...
% 9 - mine
% 10 - newly discovered mine
% 11 - safe to click
% 12 - solved number

[m, n] = size(board);
tileSize = horLines(2)-horLines(1)-1;
board(board == 11) = -1;

for i = 1:m
    for j = 1:n
        %         tiles, once identified, don't change (unless there are
        %         questionmarks)
        if(board(i, j) < 0)
            segment = screen(horLines(i):horLines(i)+tileSize, vertLines(j):vertLines(j)+tileSize, :);
            [color, peakColor] = sampleColor(segment);

			% Beautiful handcrafted decision tree to classify cells based on color content
            if(all(peakColor > 180))
                if(color(1) > 100)
                    if(color(2) > 100)
                        board(i, j) = 0;	%Gray cell
                    else
                        if(color(2) < 20 && color(3) < 20)
                            if(color(1) > 150)
                                board(i, j) = 3;	%3 mines adjacent
                            else
                                board(i, j) = 5;	%5 mines adjacent
                            end
                        end
                    end
                elseif(color(2) > 80 && color(3) < 40 && color(1) < 50)
                    board(i, j) = 2;	%2 mines adjacent
                else
                    if(color(1) < 50 && color(2) < 20 && color(3) > 100)
                        board(i, j) = 4;	%4 mines adjacent
                    elseif(color(1) < 100 && color(2) < 100 && color(3) > 150)
                        board(i, j) = 1;	%1 mine adjacent
                    elseif(color(1) < 40 && color(2) > 100 && color(3) > 100)
                        board(i, j) = 6;	%6 mines adjacent
                    end
                end
            end
        end
    end
end