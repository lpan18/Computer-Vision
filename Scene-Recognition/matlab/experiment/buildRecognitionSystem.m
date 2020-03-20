clear all;
close all;

load('../data/traintest.mat', 'train_imagenames', 'train_labels');
load('dictionaryEigen.mat','filterBank','dictionaryEigen');

T = length(train_imagenames);
K = size(dictionaryEigen, 1);
trainLabels= train_labels;

trainFeatures = zeros(T, K);
dictionary = dictionaryEigen;
for i=1:T
    load(strcat('../data/', strrep(train_imagenames{i},'.jpg','_eigen.mat')),'wordMap');
    trainFeatures(i, :) = getImageFeatures(wordMap, K);
end
save('visionEigen.mat','dictionary','filterBank','trainFeatures','trainLabels')