clear all;
close all;

addpath('../matlab');
[output1] = test('../images/image1.JPG', 64);
[output2] = test('../images/image2.JPG', 64);
[output3] = test('../images/image3.png', 64);
[output4] = test('../images/image4.jpg', 16);

function [output] = test(path, fontsize)
    layers = get_lenet();
    layers{1}.batch_size = 1;
    load('lenet.mat');
    I = imread(path);
    if (ndims(I) == 3)
        I = rgb2gray(I);
    end
    I = imbinarize(I);
    I = 1 - I; % white-number, black-background
    output = I;
    % label connected components in 2-D binary image
    % n the number of connected objects
    [L, n] = bwlabel(I); 
    
    for i = 1:n
       [r, c] = find(L == i);
       min_r = min(r);
       max_r = max(r);
       min_c = min(c);
       max_c = max(c);
       % if the box is too small, ignore it
       if max_r - min_r < 5 && max_c - min_c < 5
           continue
       end
       bbox = I(min_r : max_r, min_c : max_c);
%        figure, imshow(bbox)
       [m, n] = size(bbox);
       occupy_ratio = sum(bbox == 1, 'all')/(m*n);
       if m > n
          bbox = padarray(bbox, [0 round((m-n)/2)], 0); % pad with backgroud
       else
          bbox = padarray(bbox, [round((n-m)/2) 0], 0); 
       end
       if occupy_ratio < 0.4
%            figure; imshow(bbox)
           se = strel('sphere',3);
%            bbox = imdilate(bbox,se);
           bbox = imdilate(bbox,se);
%            figure; imshow(bbox)
       end
       n_dim = 28; p = 5;
       xtest = imresize(bbox, [n_dim-2*p, n_dim-2*p]);
       xtest = padarray(xtest, [p p], 0)'; 
       xtest = reshape(xtest, [], 1);
       [~, P] = convnet_forward(params, layers, xtest);
       [~, pred_label] = max(P);
       pred_digit = pred_label - 1;
       % x -> min_c, y -> min_r postition of text
       output = insertText(output, [min_c, min_r], pred_digit, 'FontSize', fontsize, 'TextColor','red'); 
    end
    figure; imshow(output);
end

