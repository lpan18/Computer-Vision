function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
    % Normalize points
    pts1 = pts1./M;
    pts2 = pts2./M;
    % Find the svd of A
    A = [pts2(:,1).*pts1(:,1), pts2(:,1).*pts1(:,2), pts2(:,1), pts2(:,2).*pts1(:,1), pts2(:,2).*pts1(:,2), pts2(:,2), pts1(:,1), pts1(:,2), ones(size(pts1,1),1)];
    [U,S,V] = svd(A);
    F = V(:, end);
    % Enforce Rank 2 constraint on F
    F = reshape(F, [3 3])';
    [U,S,V] = svd(F);
    S(3,3) = 0;
    F = U*S*V';
    % Refine solution
%     F = refineF(F,pts1,pts2);
    % Un-normalize F
    T = [1/M 0 0; 0 1/M 0; 0 0 1];
    F = T'*F*T;
%     disp(cell2mat(compose('%10.7f',F)))
end