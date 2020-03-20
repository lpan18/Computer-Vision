function [dictionary] = getDictionary(imgPaths, alpha, K)
k = 0.06;
T = size(imgPaths{1},2); %1331 
[filterBank] = createFilterBank();
pixelResponses = zeros(alpha*T,3*(length(filterBank)));
min_num = alpha;
for i = 1 : T
    path = strcat('../data/', imgPaths{1}{i});
    I = im2double(imread(path));
    if ndims(I) == 3
        I = rgb2gray(I);
    end
    [filterResponses] = extractFilterResponses(I, filterBank);
    % Detect corners using minimum eigenvalue algorithm
%     corners = detectMinEigenFeatures(I);
%     points = floor(corners.selectStrongest(alpha).Location);
    points = corner(I, 'MinimumEigenvalue',alpha,'QualityLevel',0.00000000001);
    for j=1:alpha
        fr_p = filterResponses(points(j, 2), points(j, 1), :);
        pixelResponses((i-1)*alpha+j,:) = reshape(fr_p, 1, 3 * (length(filterBank)));
    end
end
[~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
end