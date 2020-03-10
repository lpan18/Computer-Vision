% extract filter responses
function [filterResponses] = extractFilterResponses(I, filterBank)
[H, W, C] = size(I);
n = size(filterBank,1); % number of filters (20)
filterResponses = zeros(H, W, C*n);

% add dimensions for gray image
img = I;
if ndims(I) ~= 3
    img(:,:,1) = I;
    img(:,:,2) = I;
    img(:,:,3) = I;
end

[L,a,b] = RGB2Lab(img(:,:,1),img(:,:,2),img(:,:,3));
newI = cat(3, L, a, b);
% figure, imshow([L a b]);
% apply all of the n filters on each of the 3 color channels of the input image.
for i = 1:n
%     filterResponses(:,:,i*3-2:i*3)= conv2(newI, filterBank{i},'same');
    filterResponses(:,:,i*3-2:i*3)= imfilter(newI, filterBank{i});
end
end