clear all;
% Load an image, a CAD model cad, 2D points x and 3D points X
load('../data/PnP.mat', 'image', 'cad', 'x', 'X');
% Run estimate_pose and estimate_params to estimate camera matrix P, intrinsic matrix K, rotation matrix R, and translation t
P = estimate_pose(x, X);
[K, R, t] = estimate_params(P);
% Project the given 3D points X onto the image
X(4,:) = 1;
x_proj = P*X;
x_proj = x_proj(1:2,:)./x_proj(3,:);
% Plot the given 2D points x and the projected 3D points on screen
figure, imshow(image); 
hold on;
plot(x(1,:), x(2,:), 'go','LineWidth', 1, 'MarkerSize', 10); % green circle
plot(x_proj(1, :), x_proj(2, :), 'k.', 'MarkerSize', 10); % black dot
% Draw the CAD model rotated by your estimated rotation R on screen
v_rot = (R * cad.vertices')';
figure, trimesh(cad.faces, v_rot(:,1), v_rot(:,2), v_rot(:,3),'edgecolor', 'k');
% Project the CAD?s all vertices onto the image and draw the projected CAD model overlapping with the 2D image
v = cad.vertices;
v(:,4) = 1;
v_proj = (P*v')';
v_proj = v_proj(:,1:2)./v_proj(:,3);
figure;
ax = axes;
imshow(image);
hold on;
% patch(ax, 'Faces', cad.faces, 'Vertices', cad.vertices, 'FaceColor', 'blue', 'FaceAlpha', .3, 'EdgeColor', 'none'); % blue CAD model
patch(ax, 'Faces', cad.faces, 'Vertices', v_proj, 'FaceColor', 'red', 'FaceAlpha', .3, 'EdgeColor', 'none'); % red projected CAD model