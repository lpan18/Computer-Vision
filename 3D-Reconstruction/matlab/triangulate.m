function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
    [m,n] = size(pts1);
    Pts3d = zeros(m,4);
    for i=1:m
        A = [pts1(i,2)* P1(3,:) - P1(2,:);
             P1(1,:) - pts1(i,1)*P1(3,:);
             pts2(i,2)*P2(3,:) - P2(2,:);
             P2(1,:) - pts2(i,1)*P2(3,:)];
        [U, S, V] = svd(A);
        Pts3d(i,:) = V(:,end)';
    end
    Pts3d = Pts3d./Pts3d(:,4);
    pts3d = Pts3d(:,1:3);
end