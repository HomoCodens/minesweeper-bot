% Setup stuff
clear;
h = actxserver('WScript.Shell');    %Used to send keystrokes
h.AppActivate('Minesweeper');       %Activate the window

horLines = [];						%Positions of horizontal and vertical lines
vertLines = [];
board = [];							%Matrix to hold board state
first = true;						%Helpers
breakCounter = 0;

mode = 'n';

% while true
for i = 1:1000

    rect = [20, 447-50, 1050-450, 1080-263-203-34-38+50];
    makeMove(rect, horLines+1, vertLines+1, 13);			%Move mouse off the board to avoid highlighting a cell
    if(mode == 'a')
        rect = [20, 290, 1250, 700];
    end
    ascr = getscreen(rect);									%Grab screen content
    ascr = uint8(ascr.cdata);
    
    if(isempty(vertLines))									%Initialize cell bounds and board state (only in first iteration)
        [horLines, vertLines] = mineBounds(ascr);
        board = -1*ones(length(horLines)-1, length(vertLines)-1);
    end
    
    board = parseBoard(ascr, horLines, vertLines, board);	%Analyze board content from screenshot
    
    board = getMove(board, first);							%Get positions of mines/safe spaces (special flags in board matrix)
    
    showmove(ascr, horLines, vertLines, board);				%Visualize move
    
    h.AppActivate('Minesweeper');							%Send move to game
    makeMove(rect, horLines, vertLines, board);
    board(board == 10) = 9;
    
    if(first)												%On first move, wait a moment for the start animation
        pause(0.2);
        first = false;
    end
    
    [hlossLines, vlossLines] = mineBounds(ascr);			%Find cell bounds again (will be different if loss message window is displayed over the board)
    if(length(hlossLines) < length(horLines) && length(vlossLines) < length(vertLines))
		%The cell bounds have changed -> The loss message is being displayed and we have lost, reset
        fprintf('\nKABOOOMM!!!\n\n');
        pause(1);
        h.SendKeys('{ENTER}');
        board = -1*ones(length(horLines)-1, length(vertLines)-1);
        pause(1);
    end
    
    if(sum(sum(board == -1)) == 0)
		%There are no more unknown cells on the board and we have not lost -> win, reset
        fprintf('\nI can haz cookie now?\n\n');
        pause(1);
        h.SendKeys('{ENTER}');
        pause(0.5);
        h.SendKeys('{ENTER}');
        board = -1*ones(length(horLines)-1, length(vertLines)-1);
        pause(1);
    end

end