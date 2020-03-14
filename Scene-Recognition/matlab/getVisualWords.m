% Map each pixel in the image to its closest word in the dictionary
function [wordMap] = getVisualWords(I, filterBank, dictionary)
[m, n, ~] = size(I);
I = im2double(I); % 320*214*3
[filterResponses] = extractFilterResponses(I, filterBank);
filterResponses = reshape(filterResponses, [], 3*size(filterBank,1)); % 68484*60
[~, wordMap] = pdist2(dictionary, filterResponses, 'euclidean','Smallest',1); 
wordMap = reshape(wordMap, m, n);
% distances = pdist2(fr_reshaped, dictionary'); % 68480*100
% [~, index] = min(distances');
% wordMap = reshape(index,[m, n]);
end