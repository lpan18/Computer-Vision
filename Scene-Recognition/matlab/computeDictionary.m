clear all;
close all;
alpha = 50; %500
K = 100;
% Get a list of the training image paths
load('../data/traintest.mat');
imgPaths={train_imagenames};
% Get alpha points for each image and put it into an array
[filterBank] = createFilterBank();
[dictionaryRandom] = getDictionary(imgPaths, alpha, K, 'random');
save('dictionaryRandom.mat','filterBank','dictionaryRandom');
[dictionaryHarris] = getDictionary(imgPaths, alpha, K, 'harris');
save('dictionaryHarris.mat','filterBank','dictionaryHarris');
