function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
    [n,m] = size(im1);
    w = (windowSize-1)/2 ;
    dispM = zeros(size(im1));
    dist = zeros(1, maxDisp+1);
    for y = w+1:n-w
        for x = w+1+maxDisp:m-w-maxDisp
            for d = 0:maxDisp
                diff = im1(y-w:y+w,x-w:x+w) - im2(y-w:y+w,x-w-d:x+w-d);
                dist(d+1) = sqrt(sum(sum(diff.*diff)));
            end
            dispM(y,x)=find(dist==min(dist),1)-1;
        end
    end
end