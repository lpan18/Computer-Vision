function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
    [n, m] = size(locs1);
    X1 = [locs1(:,1),locs1(:,2),ones(n,1)]';
    X2 = [locs2(:,1),locs2(:,2),ones(n,1)]';
    
    num_of_iterations = 100;
    threshold = 10;
    min_pairs = 4;
    inliers = zeros(1,n);
    points_pair = zeros(min_pairs, 2);
    
    % in randperm, K must be less than or equal to N.
    if size(locs1,1) < min_pairs
        min_pairs = size(locs1,1); 
    end

    for i = 1:num_of_iterations
        idx = randperm(size(locs1,1),min_pairs);
        locs1_r = locs1(idx,:);
        locs2_r = locs2(idx,:);
        % Compute H and tranfered points
        H = computeH_norm(locs1_r,locs2_r);
        X1_trans = H*X2;
        X1_trans(1,:) = X1_trans(1,:)./X1_trans(3,:);
        X1_trans(2,:) = X1_trans(2,:)./X1_trans(3,:);
        % Compute difference
        diff = X1-X1_trans;
        dist = sqrt(diff(1,:).*diff(1,:) + diff(2,:).*diff(2,:));
        curr_inliers = dist < threshold;
        if sum(curr_inliers) > sum(inliers)
            inliers = curr_inliers;
            points_pair = locs2_r;
        end
    end
    points_pair
    indices = find(inliers==1) ;
    bestH2to1 = computeH_norm(locs1(indices,:),locs2(indices,:));
%Q2.2.3
end

