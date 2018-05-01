function board = getMove(board, first)
if(nargin == 1)
    first = false;
end

[m, n] = size(board);
bestGuess = [0, 0];
guessConfidence = 0;

%Iterate over the board
for i = 1:m
	for j = 1:n
	
		%If the cell has a known number of neighbouring mines
		if(board(i, j) > 0 && board(i, j) <= 8)
		
			%Count its neighbouthood
			[nBomb, nVeiled] = adjacency(board, i, j);
			
			%For guessing
			confidence = nVeiled/(board(i, j) - nBomb);
			
			%If there are as many adjacent water spaces as remaining mines, mark all as mined
			if(nVeiled == board(i, j) - nBomb)
				for k = i-1:i+1
					if(k > 0 && k <= m)
						for l = j-1:j+1
							if(l > 0 && l <= n) % && ~all([k, l] == [i, j]))
								if(board(k, l) == -1)
									board(k, l) = 10;
								end
							end
						end
					end
				end
				board(i, j) = 12;
				
			%If all neighbouring mines have been found, mark remaining water spaces as safe
			elseif(0 == board(i, j) - nBomb) 
				for k = i-1:i+1
					if(k > 0 && k <= m)
						for l = j-1:j+1
							if(l > 0 && l <= n && ~all([k, l] == [i, j]))
								if(board(k, l) == -1)
									board(k, l) = 11;
								end
							end
						end
					end
				end
				board(i, j) = 12;
				
			%Update best guess
			elseif(confidence > guessConfidence)
				bestGuess = [i, j];
				guessConfidence = confidence;
			end
		end
	end
end

if(~any(board == 10 | board == 11))
%     fprintf('Making random choice...\n');
    if(all(all(board == -1)))				%The game has just started, we have to guess
        fprintf('Making first move...\n');
        candidates = find((board == -1));
        pick = randi(length(candidates));
        [i, j] = ind2sub([m, n], candidates(pick));
        board(i, j) = 11;
    else	%Note: While neat, guessing near a number is actually a worse strategy than shooting into the blue
        candidates = [];
        for r = bestGuess(1)-1:bestGuess(1)+1
            if(r > 0 && r <= m)
                for c = bestGuess(2)-1:bestGuess(2)+1
                    if(c > 0 && c <= n)
                        if(board(r, c) == -1 && ~(r == bestGuess(1) && c == bestGuess(2)))
                            candidates = [candidates; r, c];
                        end
                    end
                end
            end
        end
        if(isempty(candidates))
            [rows, cols] = ind2sub([m, n], find(board == -1));
            candidates = [rows cols];
        end
        if(~isempty(candidates))
            pick = randi(size(candidates, 1));
            board(candidates(pick, 1), candidates(pick, 2)) = 11;
            beep;
            fprintf('Guessing at (%d, %d) with confidence %d...\n', candidates(pick, 1), candidates(pick, 2), guessConfidence);
        end
    end
end
    