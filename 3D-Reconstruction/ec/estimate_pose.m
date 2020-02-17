function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]
    n = size(x,2);
    A = zeros(2*n, 12);
    for k = 1:n
        A(2*k-1,:) = [0, 0, 0, 0, X(1, k), X(2, k), X(3, k), 1, -x(2, k)*X(1, k), -x(2, k)*X(2, k), -x(2, k)*X(3, k), -x(2, k)];
        A(2*k,:) = [X(1, k), X(2, k), X(3, k), 1, 0, 0, 0, 0, -x(1, k)*X(1, k), -x(1, k)* X(2, k), -x(1, k)*X(3, k), -x(1, k)];
    end
    [U, S, V] = svd(A);
    P = V(:,end); % 12*1
    P = reshape(P, [4 3])';
end