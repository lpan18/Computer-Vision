% Harris corner detection algorithm to select key points from an input image

% Apply non-max suppression to avoid picking many corners from a single location. 
% Non-max suppression has 2 steps: Extract local-maxima then threshold them to keep 
% only pixels with high responses. In the 2nd step, instead of thresholding the response 
% function, simply take the top ? response as the corners (after extracting local-maxima), 
% and return their coordinates. A good value for the k parameter is 0.04 - 0.06. 
% For further improvements, you can divide an image into say 4x4 blocks and extract
% the top ?/16 peaks from each block so that features are well distributed in an image.

function [points] = getHarrisPoints(I, alpha, k)
if ndims(I) == 3
    I = rgb2gray(I);
end
% Compute the images X and Y gradients
[Ix,Iy] = imgradientxy(I);
Ixx = Ix.*Ix;
Iyy = Iy.*Iy;
Ixy = Ix.*Iy;
window = ones(5);
% Compute the covariance matrix
sumIxx = imfilter(Ixx, window);
sumIxy = imfilter(Ixy, window);
sumIyy = imfilter(Iyy, window);
R = sumIxx.*sumIyy - sumIxy.*sumIxy - k *(sumIxx + sumIyy).^2; % 256*320
[m, n] = size(R);
n_block = 2;
r_step = floor(m/n_block);
c_step = floor(n/n_block);
rows = [];
cols = [];
alpha_hat = ceil(alpha/(n_block*n_block)); % get more points, cause sometimes not divisible
for r = 1:r_step:r_step*n_block
    for c = 1:c_step:c_step*n_block
        R_hat = R(r:r+r_step-1, c:c+c_step-1); 
        [~,inds] = sort(R_hat(:),'descend');
        [row, col] = ind2sub(size(R_hat), inds(1:alpha_hat));
        rows = [rows; row+r-1];
        cols = [cols; col+c-1];
    end
end
points = [cols(1:alpha),rows(1:alpha)]; % x,y
end
