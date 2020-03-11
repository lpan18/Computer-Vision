% create a dictionary of visual words
function [dictionary] = getDictionary(imgPaths, alpha, K, method)
k = 0.06;
points = [];
T = size(imgPaths{1},2); %1331 
[filterBank] = createFilterBank();
pixelResponses = zeros(alpha*T,3*(length(filterBank)));
for i = 1 : T
    path = strcat('../data/', imgPaths{1}{i});
    I = im2double(imread(path));
    [filterResponses] = extractFilterResponses(I, filterBank);
    if strcmp(method, 'random')
        [points] = getRandomPoints(I, alpha);
    elseif strcmp(method, 'harris')
        [points] = getHarrisPoints(I, alpha, k);
    end
     
    for j=1:alpha
        fr_p = filterResponses(points(j, 2), points(j, 1), :);
        pixelResponses((i-1)*alpha+j,:) = reshape(fr_p, 1, 3 * (length(filterBank)));
    end
end
[~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
end