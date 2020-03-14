% % takes an image and an alpha, and returns a matrix of size alpha × 2 of
% % random pixels locations inside the image
function [points] = getRandomPoints(I, alpha)
    m = size(I, 1);
    n = size(I, 2);
    s = [m, n];
    inds = randperm(numel(rand(s)), alpha);  
    [pts_x, pts_y] = ind2sub(s, inds);      
    points = [pts_y(:), pts_x(:)];
end