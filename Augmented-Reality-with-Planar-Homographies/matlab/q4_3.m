%Q4.3
close all;
clear all;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');
[locs1, locs2] = matchPics(cv_cover, cv_desk);
% Compute H
[H2to1] = computeH(locs1, locs2);
% [H2to1] = computeH_norm(locs1, locs2);
% [H2to1,inliers] = computeH_ransac(locs1, locs2);
% Generate random points
rand_x = [251,288,421,412,400,414,436,480,513,491];
rand_y = [297,248,212,246,308,361,355,221,293,357];
% rand_x = [321,437,469,363];
% rand_y = [377,233,397,213];
X2 = [rand_x; rand_y]; % 2*10
X2_3d = [X2; ones(size(rand_x))]; % 3*10
% Calculate X1
X1_3d = H2to1*X2_3d; % 3*10
X1(1,:) = X1_3d(1,:)./X1_3d(3,:);
X1(2,:) = X1_3d(2,:)./X1_3d(3,:);
% X1'
% X2'
% Plot
figure;
showMatchedFeatures(cv_cover, cv_desk, X1', X2', 'montage');
title('Homography Computation');
