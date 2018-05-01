function makeMove(rect, hl, vl, board)
%Get Java Robot
import java.awt.*;
import java.awt.event.*;
robot = Robot;

topLeft = [rect(1), 1050-rect(4)-rect(2)];
offset = [12, 12];
[m, n] = size(board);

%Special case for moving mouse off the board
if(size(board, 1) == 1)
    p = topLeft - offset;
    robot.mouseMove(p(1), p(2));
end

%Iterate over all cells, left or right clicking where appropriate
for i = 1:m
    for j = 1:n
        if(board(i, j) == 10)
            mask = InputEvent.BUTTON3_MASK;
            fprintf('Setting flag at (%d, %d)\n', i, j);
        elseif(board(i, j) == 11 || board(i, j) == -2)
            mask = InputEvent.BUTTON1_MASK;
            fprintf('Uncovering field (%d, %d)\n', i, j);
        end
        if(board(i, j) == 10 || board(i, j) == 11 || board(i, j) == -2)
            clickPos = topLeft + offset + [hl(j), vl(i)];
            robot.mouseMove(clickPos(1), clickPos(2));
            robot.mousePress(mask);
            robot.mouseRelease(mask);
            pause(0.01);
        end
    end
end