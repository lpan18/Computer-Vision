function [rhos, thetas] = myHoughLines(H, nLines)
%Your implemention here
    rhos = zeros(nLines, 1);
    thetas = zeros(nLines, 1);
    % apply non-maximum suppression
    HNms = H;
    [m, n] = size(HNms);
    for i = 2:m-1
        for j = 2:n-1
            if H(i,j) < H(i, j-1) || H(i,j) < H(i, j+1) || H(i,j) < H(i-1, j) || H(i,j) < H(i+1, j)
                HNms(i,j) = 0;
            end
        end
    end
    % sort scores
    sorted = sort(HNms(:),'descend');
    for i = 1:nLines
        % get the indexes highest scoring cells 
        [rhoIdx, thetaIdx] = find(HNms==sorted(i));
        rhos(i) = rhoIdx(1); % get the first element if multiples
        thetas(i) = thetaIdx(1);
        HNms(rhos(i),thetas(i)) = 0; % to avoid duplicates
    end
end