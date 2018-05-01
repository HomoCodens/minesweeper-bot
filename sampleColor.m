%Finds the lowest and highest intensity colors in an image segment
function [colorMin, colorMax] = sampleColor(segment)
gSegment = rgb2gray(segment(5:end-5,5:end-5, :));
gSegment(gSegment < 10) = 200;
[~, minPos] = min(gSegment(:));
[~, maxPos] = max(gSegment(:));
[mp1, mp2] = ind2sub(size(gSegment), minPos);
[mxp1, mxp2] = ind2sub(size(gSegment), maxPos);
colorMin = segment(mp1+4, mp2+4, :);
colorMin = colorMin(:);
colorMax = segment(mxp1+4, mxp2+4, :);
colorMax = colorMax(:);