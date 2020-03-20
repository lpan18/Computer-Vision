clear all;
close all;
alpha = 500;
K = 100;
% Get a list of the training image paths
load('../data/traintest.mat');
imgPaths={train_imagenames};
% Get alpha points for each image and put it into an array
[filterBank] = createFilterBank();
[dictionaryHarris] = getDictionary(imgPaths, alpha, K, 'eigen');
save('dictionaryEigen.mat','filterBank','dictionaryEigen');
