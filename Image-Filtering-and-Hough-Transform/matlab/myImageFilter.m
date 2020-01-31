function [img1] = myImageFilter(img0, h)
    [m, n] = size(img0);
    [kr, kc] = size(h);
    % add paddings to image (filter h is odd sized along both dimensions)
    imgPadded = padarray(img0, [floor(kr/2) floor(kc/2)]);
    % columnize image
    imgColumnized = im2col(imgPadded, [kr kc]);
    % rotate kernel by 180 degree, and columnize kernel 
    hColumnized = im2col(rot90(h,2), [kr kc]);
    % do 2D convolution
    img1 = reshape(sum(hColumnized.*imgColumnized), [m, n]);
%     figure, imshow(img1);
%     % verification
%     test = conv2(img0, h);
%     figure, imshow(test);
end