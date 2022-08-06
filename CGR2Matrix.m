function matrix = CGR2Matrix( seq, SCALE, pixelValue )

%% CGR phase
% seq = 'AAGTTT';
[x, y] = CGR( seq );
% SCALE = 65;
% pixelValue = 1;

%% CGR to pixel Matrix
matrix = zeros(SCALE, SCALE);
for i = 1 : length( seq ) + 1
    rowInd = ceil(SCALE * x(i));
    colInd = ceil(SCALE * y(i));
    if (rowInd > SCALE)
        rowInd = SCALE;
    end
    if (colInd >= SCALE)
        colInd = SCALE - 1;
    end
    matrix(SCALE - colInd, rowInd) = pixelValue;
end

% imagesc(matrix);
% end

