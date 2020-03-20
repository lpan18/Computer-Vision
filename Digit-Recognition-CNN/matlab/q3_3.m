% Q3.3
clear all;
close all;

layers = get_lenet();
load lenet.mat
num = 5;
n_dim = 28;
x_real_world = zeros(n_dim*n_dim, num);
y_real_world = zeros(1, num);

for i = 1:num
    I = imread(strcat('../test/', int2str(i), '.png'));
    if (ndims(I) == 3)
        I = rgb2gray(I);
    end
    I = imresize(255-I,[n_dim, n_dim]);
%     I = flipud(rot90(I));
    I = I';
    I = reshape(I, [], 1);
    x_real_world(:, i) = I;
    y_real_world(:, i) = i;
%     img = x_real_world(:, i);
%     img = reshape(img, 28, 28);
%     figure, imshow(img);
end

ypred = [];
layers{1}.batch_size = 1;

for i=1:size(x_real_world, 2)
    [output, P] = convnet_forward(params, layers, x_real_world(:, i));
    [~, pred_label] = max(P);
    ypred = [ypred, pred_label];
end
n = num;
disp(ypred)
confusion_matrix = zeros(n, n);
for i = 1 : size(y_real_world, 2)
    confusion_matrix(y_real_world(i), ypred(i)) = confusion_matrix(y_real_world(i), ypred(i)) + 1;
end
disp(confusion_matrix)