%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
[m, n] = size(ytest); % 1* 500
ypred = [];
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [~, pred_label] = max(P);
    ypred = [ypred, pred_label];
end
n = 10;
confusion_matrix = zeros(n, n);
for i = 1 : size(ytest, 2)
    confusion_matrix(ytest(i), ypred(i)) = confusion_matrix(ytest(i), ypred(i)) + 1;
end
disp(confusion_matrix)