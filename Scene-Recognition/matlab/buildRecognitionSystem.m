clear all;
close all;

load('../data/traintest.mat', 'train_imagenames', 'train_labels');
load('dictionaryRandom.mat','filterBank','dictionaryRandom');
load('dictionaryHarris.mat','filterBank','dictionaryHarris');

T = length(train_imagenames);
K = size(dictionaryHarris, 1);
trainLabels= train_labels;

trainFeatures = zeros(T, K);
dictionary = dictionaryRandom;
for i=1:T
     load(strcat('../data/', strrep(train_imagenames{i},'.jpg','_random.mat')),'wordMap');
     trainFeatures(i, :) = getImageFeatures(wordMap, K);
end
save('visionRandom.mat','dictionary','filterBank','trainFeatures','trainLabels')

trainFeatures = zeros(T, K);
dictionary = dictionaryHarris;
for i=1:T
    load(strcat('../data/', strrep(train_imagenames{i},'.jpg','_harris.mat')),'wordMap');
    trainFeatures(i, :) = getImageFeatures(wordMap, K);
end
save('visionHarris.mat','dictionary','filterBank','trainFeatures','trainLabels')