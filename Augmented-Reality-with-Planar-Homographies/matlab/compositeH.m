function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
% H_template_to_img = inv(H2to1);

    %% Create mask of same size as template
    mask = ones(size(template,1),size(template,2));
    %% Warp mask by appropriate homography
    mask_w = warpH(mask, H2to1, size(img));
    %% Warp template by appropriate homography
    template_w = warpH(template, H2to1, size(img));
    %% Use mask to combine the warped template and the image
    composite_img = img;
    [x,y] = find(mask_w~=0);
    for i = 1:size(x)
        composite_img(x(i),y(i),:) = template_w(x(i),y(i),:);
    end
end