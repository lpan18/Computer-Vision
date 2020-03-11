% Extracts the histogram of visual words within the given image
function [ h ] = getImageFeatures(wordMap, dictionarySize)
h = zeros(1, dictionarySize);
flatten = wordMap(:);
for i = 1:dictionarySize
    h(i) = sum(flatten == i);
end
% L1 normalize the histogram
% h = h/sum(h);
h = h/max(h);
end