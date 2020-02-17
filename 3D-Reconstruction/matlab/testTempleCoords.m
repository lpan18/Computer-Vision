% A test script using templeCoords.mat
%
% Write your code here
% Load the two images and the point correspondences from someCorresp.mat
im1 = imread("../data/im1.png");
im2 = imread("../data/im2.png");
load("../data/someCorresp.mat");
M = max(size(im1,1),size(im2,2));
% Run eightpoint to compute the fundamental matrix F
F = eightpoint(pts1, pts2, M);
% displayEpipolarF(I1, I2, F);
% Load the points in image 1 contained in templeCoords.mat and run your epipolarCorrespondences on them to get the corresponding points in image 
load("../data/templeCoords.mat");
[m,~] = size(pts1);
[pts2] = epipolarCorrespondence(im1, im2, F, pts1);
% [coordsIM1, coordsIM2] = epipolarMatchGUI(im1, im2, F);
% Load intrinsics.mat and compute the essential matrix E.
load("../data/intrinsics.mat");
E = essentialMatrix(F, K1, K2);
% disp(cell2mat(compose('%10.7f',E)))
% Compute the first camera projection matrix P1 and use camera2.m to compute the four candidates for P2
% For P1 you can assume no rotation or translation
M1 = [1,0,0,0; 0,1,0,0; 0,0,1,0;];
P1 = K1*M1;
M2s = camera2(E); %3*4*4
M2_r = zeros(3,4);
pts3d_r = zeros(size(pts1,1),3);
% Run your triangulate function using the four sets of camera matrix candidates, the points from templeCoords.mat and their computed correspondences.
for i = 1:4
    M2 = M2s(:,:,i);
    P2 = K2*M2;
    pts3d = triangulate(P1, pts1, P2, pts2);
    if all(pts3d(:,3) > 0)
        pts3d_r = pts3d;
        M2_r = M2;
    end
end
% Figure out the correct P2 and the corresponding 3D points.
% Hint: You?ll get 4 projection matrix candidates for camera2 from the essential matrix. The correct configuration is the one for which most of the 3D points are in front of both cameras (positive depth).
% Use matlab's plot3 function to plot these point correspondences on screen
plot3(pts3d_r(:,1),pts3d_r(:,2) ,pts3d_r(:,3), '*');

% save extrinsic parameters for dense reconstruction
R1 = M1(:,1:3);
t1 = M1(:,4);
R2 = M2_r(:,1:3);
t2 = M2_r(:,4);
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');

% compute error
load('../data/someCorresp.mat');
pts3d_some = zeros(size(pts1,1),3);
for i = 1:4
    M2 = M2s(:,:,i);
    P2 = K2*M2;
    pts3d = triangulate(P1, pts1, P2, pts2 );
    if all(pts3d(:,3) > 0)
        pts3d_some = pts3d;
    end
end
pts1_proj = zeros(size(pts1,1),3);
for i = 1:size(pts1,1)
    pts1_proj(i,:) = (P1 * [pts3d_some(i,1);pts3d_some(i,2);pts3d_some(i,3);1])';
end
pts1_proj = pts1_proj./pts1_proj(:,3);
pts1_proj = pts1_proj(:,1:2);
error = mean(sqrt(sum((pts1_proj - pts1).^2,2)));


