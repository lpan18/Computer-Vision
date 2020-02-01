function [ H2to1 ] = computeH( x1, x2 )
%COMPUTE H Computes the homography between two sets of points
    x1_x=x1(:,1); x1_y=x1(:,2);
    x2_x=x2(:,1); x2_y=x2(:,2);
    O = zeros(size(x1_x));
    I = ones(size(x1_x));
    A = [-x2_x, -x2_y, -I, O, O, O, x2_x.*x1_x, x2_y.*x1_x, x1_x;
         O, O, O, -x2_x, -x2_y, -I, x2_x.*x1_y, x2_y.*x1_y, x1_y];
    [~,~,V] = svd(A);
    H = V(:,end);
    H2to1 = reshape(H,[3,3])';
end
