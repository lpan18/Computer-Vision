% extract filter responses
function [filterResponses] = extractFilterResponses(I, filterBank)
[H, W, C] = size(I);
n = size(filterBank,1); % number of filters (20)
filterResponses = zeros(H, W, C*n);

% add dimensions for gray image
if ndims(I) ~= 3
    newI(:,:,1) = I;
    newI(:,:,2) = I;
    newI(:,:,3) = I;
    I = newI;
end

[L,a,b] = RGB2Lab(I(:,:,1), I(:,:,2), I(:,:,3));
I = cat(3, L, a, b);
% figure, imshow([L a b]);
% apply all of the n filters on each of the 3 color channels of the input image.
for i = 1:n
%     filterResponses(:,:,i*3-2:i*3)= conv2(newI, filterBank{i},'same');
    filterResponses(:,:,i*3-2:i*3)= imfilter(I, filterBank{i});
end
end