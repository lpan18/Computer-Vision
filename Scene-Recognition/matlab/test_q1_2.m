clear all;
close all;
alpha=500;
k=0.05;
I = imread('../data/campus/sun_abslhphpiejdjmpz.jpg');
% I = imread('../data/desert/sun_adpbjcrpyetqykvt.jpg');
% I = imread('../data/landscape/sun_afhhnevciblqzhjp.jpg');
I = im2double(I);

% [random_pts]=getRandomPoints(I, alpha);
% figure, imshow(I);
% hold on;
% plot(random_pts(:,1),random_pts(:,2),'b.','MarkerSize',4);

[harris_pts] = getHarrisPoints(I, alpha, k);
figure, imshow(I);
hold on;
plot(harris_pts(:,1),harris_pts(:,2),'b.','MarkerSize',4);