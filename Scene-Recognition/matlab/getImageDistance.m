function [dist] = getImageDistance(hist1, histSet, method)
    n = size(histSet, 1);
    if strcmp(method, 'euclidean')
        dist = pdist2(hist1, histSet, 'euclidean'); % 1*1331
    elseif strcmp(method, 'chi2')
        hist1Set = repmat(hist1, n, 1);
        dist = sum((hist1Set - histSet).^2./(hist1Set+histSet+eps),2)/2; % 1331*1
    end
end
