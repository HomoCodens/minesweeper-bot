%Draws the screen content and overlays it with game state information
function showmove(screen, horLines, vertLines, board)
image(screen);
[m, n] = size(board);
hold on;
offs = [5, 16];
for i = 1:m
    for j = 1:n
        switch(board(i, j))
            case -1
                text(vertLines(j)+offs(1), horLines(i)+16, 'w', 'FontSize', 15, 'FontWeight', 'bold');
            case 1
                text(vertLines(j)+offs(1), horLines(i)+16, '1', 'FontSize', 15, 'FontWeight', 'bold', 'Color', [59, 84, 191]./256);
            case 2
                text(vertLines(j)+offs(1), horLines(i)+16, '2', 'FontSize', 15, 'FontWeight', 'bold', 'Color', [25, 109, 0]./256);
            case 3
                text(vertLines(j)+offs(1), horLines(i)+16, '3', 'FontSize', 15, 'FontWeight', 'bold', 'Color', [168, 7, 1]./256);
            case 4
                text(vertLines(j)+offs(1), horLines(i)+16, '4', 'FontSize', 15, 'FontWeight', 'bold', 'Color', [1, 0, 133]./256);
            case 10
                rectangle('Position', [vertLines(j), horLines(i), vertLines(j+1)-vertLines(j), horLines(i+1)-horLines(i)], 'FaceColor', [1 0 0]);
            case 11
                rectangle('Position', [vertLines(j), horLines(i), vertLines(j+1)-vertLines(j), horLines(i+1)-horLines(i)], 'FaceColor', [0 1 0]);
            case -2
                rectangle('Position', [vertLines(j), horLines(i), vertLines(j+1)-vertLines(j), horLines(i+1)-horLines(i)], 'FaceColor', [1 1 0]);
            case 12
                text(vertLines(j)+offs(1), horLines(i)+16, 's', 'FontSize', 15, 'FontWeight', 'bold', 'Color', 'w');
        end
    end
end
hold off;
axis equal;