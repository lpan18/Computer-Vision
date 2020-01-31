function [img1] = myEdgeFilter(img0, sigma)
%Your implementation here
    hsize = 2*ceil(3*sigma)+1;
    % get the kernel for the Gaussian filter
    gaussianFilter = fspecial('gaussian',hsize,sigma);
    % smooth out the image 
    img = myImageFilter(img0, gaussianFilter);
    % sobel filter, x-oriented and y-oriented
    sobelX = [1,0,-1;
              2,0,-2;
              1,0,-1];
    sobelY = [1,2,1;
              0,0,0;
              -1,-2,-1];
    % image gradients in the x and y directions
    imgx = myImageFilter(img, sobelX);
    imgy = myImageFilter(img, sobelY);
    % combine image gradients in both directions
    imgxy = sqrt(imgx.^2 + imgy.^2);
    % figure,imshow(imgxy);
    % apply non-maximum suppression
    img1 = imgxy;
    % angle matrix in degree
    theta = atan2(imgy, imgx) .* (180/pi);
    % map negative values to 0~180
    theta(theta<0) = theta(theta<0) + 180;
    [m, n] = size(img1);
     for i = 1:m
        for j = 1:n
            % border pixels
            if (i == 1 || i == m || j == 1 || j == n)
                img1(i,j)=0;
                continue;
            end
            % map to 0 degree
            angle = theta(i-1,j-1);
            if angle < 22.5 || angle > 157.5
                if imgxy(i,j) < imgxy(i, j-1) || imgxy(i,j) < imgxy(i, j+1)
                    img1(i,j) = 0;
                end
            % map to 45 degree    
            elseif angle >= 22.5 && angle < 67.5
                if imgxy(i,j) < imgxy(i-1, j-1) || imgxy(i,j) < imgxy(i+1, j+1)
                    img1(i,j) = 0;
                end
            % map to 90 degree
            elseif angle >= 67.5 && angle < 112.5
                if imgxy(i,j) < imgxy(i-1, j) || imgxy(i,j) < imgxy(i+1, j)
                    img1(i,j) = 0;
                end
            % map to 135 degree
            elseif (angle >= 112.5 && angle <= 157.5)
                if imgxy(i,j) < imgxy(i+1, j-1) || imgxy(i,j) < imgxy(i-1, j+1)
                    img1(i,j) = 0;
                end
            end
        end
    end
%     figure, imshow(img1);
end