layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
 
layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
figure, imshow(img')
 
%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
% Fill in your code here to plot the features.
n_row = 4;
n_col = 5;
for k = 2:3 % second layer and third layer
    figure;
    for i = 1:n_row
        for j = 1:n_col
            idx = sub2ind([n_row n_col], i, j);
            imgs = reshape(output{k}.data, output{k}.height, output{k}.width, []);
            img = imgs(:,:,idx)';
            subplot(n_row, n_col, idx);
            imshow(img);
        end
    end
end