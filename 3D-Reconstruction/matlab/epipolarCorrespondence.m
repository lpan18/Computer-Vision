function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
    [m,~] = size(pts1); % 288*2
    pts2 = zeros(size(pts1));
    [im1_h,im1_w,~] = size(im1);
    [im2_h,im2_w,~] = size(im2);
    win_size = 5;
    delta = 10;
    for i = 1:m
        x1 = pts1(i,1);
        y1 = pts1(i,2);
        % epipolar line 
        l = F*[x1;y1;1];
%         if (x1-win_size<1 || y1-win_size<1 || x1+win_size>im1_w || y1+win_size>im1_h)
%             continue
%         end
        X1_window = im1(y1-win_size:y1+win_size, x1-win_size:x1+win_size);
        min_err = -1;
        first = max(1, x1-delta);
        last = min(im1_w, x1+delta);
        x2_range = first:last;
        if(l(2) == 0)
            continue
        end
        y2_range =  -(l(1) * x2_range + l(3))/l(2);
        x2_range = x2_range(find(y2_range >= 1 & y2_range <= im1_h));
        y2_range = y2_range(find(y2_range >= 1 & y2_range <= im1_h));
        for j = 1:size(x2_range,2)
            x2 = x2_range(j);
            y2 = floor(y2_range(j));
            if (x2-win_size<1 || y2-win_size<1 || x2+win_size>im2_w || y2+win_size>im2_h)
                continue
            end
            X2_window = im2(y2-win_size:y2+win_size, x2-win_size:x2+win_size);
            err = sum(sum((X1_window - X2_window).^2));
            if (min_err == -1 || err < min_err)
                min_err = err;
                pts2(i,1) = x2_range(j);
                pts2(i,2) = y2_range(j);
            end
        end
    end
end