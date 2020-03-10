% Map each pixel in the image to its closest word in the dictionary
function [wordMap] = getVisualWords(I, filterBank, dictionary)
[m, n, ~] = size(I);
I = im2double(I); % 320*214*3
[filterResponses] = extractFilterResponses(I, filterBank);
fr_reshaped = reshape(filterResponses, m*n, 3*size(filterBank,1)); % 68484*60
distances = pdist2(fr_reshaped, dictionary'); % 68480*100
[~, index] = min(distances');
wordMap = reshape(index,[m, n]);
end