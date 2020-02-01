function [H2to1] = computeH_norm(x1, x2)
    %% Compute centroids of the points
    centroid1 = mean(x1);
    centroid2 = mean(x2);
    %% Shift the origin of the points to the centroid
    x1_s = x1 - centroid1;
    x2_s = x2 - centroid2;
    %% Normalize the points so that the average distance from the origin is equal to sqrt(2).
    num_points = size(x1_s,1);
    avg_dist1 = sum(sqrt(x1_s(:,1).^2 + x1_s(:,2).^2))/num_points;
    avg_dist2 = sum(sqrt(x2_s(:,1).^2 + x2_s(:,2).^2))/num_points;
    scale1 = sqrt(2)/avg_dist1;
    scale2 = sqrt(2)/avg_dist2;
    %% Similarity transform 1
    T1 = [scale1 0 0; 0 scale1 0; 0 0 1]*[1 0 -centroid1(1); 0 1 -centroid1(2); 0 0 1];
    %% Similarity transform 2
    T2 = [scale2 0 0; 0 scale2 0; 0 0 1]*[1 0 -centroid2(1); 0 1 -centroid2(2); 0 0 1];
    %% Compute Homography
    x1_t = x1_s*scale1;
    x2_t = x2_s*scale2;
    H_norm = computeH(x1_t, x2_t);
    %% Denormalization
    H2to1 = inv(T1)*H_norm*T2;
end

