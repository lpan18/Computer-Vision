% Harris corner detection algorithm to select key points from an input image
function [points] = getHarrisPoints(I, alpha, k)
if ndims(I) == 3
    I = rgb2gray(I);
end
% Compute the image?s X and Y gradients
[Ix,Iy] = imgradientxy(I);
Ixx = Ix.*Ix;
Iyy = Iy.*Iy;
Ixy = Ix.*Iy;
window = ones(5);
% Compute the covariance matrix
sumIxx = imfilter(Ixx, window);
sumIxy = imfilter(Ixy, window);
sumIyy = imfilter(Iyy, window);
R = sumIxx.*sumIyy - sumIxy.*sumIxy - k *(sumIxx + sumIyy).^2;
[~,inds] = sort(R(:),'descend');
% Take the top alpha response as the corners
[rows, cols] = ind2sub(size(R), inds(1:alpha));
points = [cols,rows]; % x,y
end