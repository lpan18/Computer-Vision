clear all;
close all;
alpha=500;
k=0.04;
% I = imread('../data/campus/sun_abslhphpiejdjmpz.jpg');
% I = imread('../data/desert/sun_adpbjcrpyetqykvt.jpg');
% I = imread('../data/landscape/sun_afhhnevciblqzhjp.jpg');
I = imread('../data/desert/sun_btidxypsdyearnbr.jpg');
I = im2double(I);
if ndims(I) == 3
    I = rgb2gray(I);
end
points = corner(I,'MinimumEigenvalue',alpha)
% points = corner(I, 'MinimumEigenvalue',alpha,'QualityLevel',0.00000000001);
size(points)
% points = floor(corners.Location(1:alpha,:));
figure; 
imshow(I);
hold on
plot(points(:,1),points(:,2),'b.','MarkerSize',6);