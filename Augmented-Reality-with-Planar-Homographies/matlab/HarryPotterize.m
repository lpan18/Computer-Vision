%Q4.6
clear all;
close all;

cover_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');
harry_img = imread('../data/hp_cover.jpg');

[m, n] = size(cover_img);
harry_resized = imresize(harry_img, [m, n]);

[locs1, locs2] = matchPics(cover_img,desk_img);
[H2to1, ~] = computeH_ransac(locs1, locs2);

% Visualization
imshow(warpH(harry_resized, inv(H2to1), size(desk_img)));
imshow(compositeH(inv(H2to1), harry_resized, desk_img));
