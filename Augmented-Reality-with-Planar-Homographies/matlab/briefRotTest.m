% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
I = imread('../data/cv_cover.jpg');
if (ndims(I) == 3)
    I = rgb2gray(I);
end
%% Compute the features and descriptors
% initiate histogram 
histogram1 = zeros(36,1);
histogram2 = zeros(36,1);
for i = 0:36
    %% Rotate image
    Ir = imrotate(I,10*i);
    %% Compute features and descriptors
    % FAST
    points1 = detectFASTFeatures(I);
    points2 = detectFASTFeatures(Ir);
    [desc1, locs1] = computeBrief(I, points1.Location);
    [desc2, locs2] = computeBrief(Ir, points2.Location);
    % SURF
    points3 = detectSURFFeatures(I); 
    points4 = detectSURFFeatures(Ir);
    [features3, validPoints3] = extractFeatures(I, points3, 'Method', 'SURF');
    [features4, validPoints4] = extractFeatures(Ir, points4, 'Method', 'SURF');
    %% Match features
    indexPairs1 = matchFeatures(desc1, desc2,'MatchThreshold', 10.0, 'MaxRatio', 0.65);
    indexPairs2 = matchFeatures(features3, features4);
    %% Update histogram
    histogram1(i+1) = size(indexPairs1, 1);
    histogram2(i+1) = size(indexPairs2, 1);
%     % visualization
%     if i == 1 || i == 3 || i == 9 || i == 18
%         locs1 = locs1(indexPairs1(:,1),:);
%         locs2 = locs2(indexPairs1(:,2),:);
%         figure;
%         showMatchedFeatures(I, Ir, locs1, locs2, 'montage');
%     end
end

%% Display histogram
x = 0:10:360;
figure, bar(x, histogram1);
title('FAST');
xlabel('rotation (degree)');
ylabel('count of matches');

figure, bar(x, histogram2);
title('SURF');
xlabel('rotation (degree)');
ylabel('count of matches');