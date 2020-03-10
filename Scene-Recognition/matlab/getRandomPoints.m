% takes an image and an alpha, and returns a matrix of size alpha × 2 of
% random pixels locations inside the image
function [points] = getRandomPoints(I, alpha)
m = size(I,1);
n = size(I,2);
points = zeros(alpha, 2);
rng(0,'twister');
points(:,1) = randi(n,alpha,1); % x
points(:,2) = randi(m,alpha,1); % y
end