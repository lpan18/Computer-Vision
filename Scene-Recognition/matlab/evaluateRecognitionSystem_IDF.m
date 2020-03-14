clear all;
close all;

dataset = load('../data/traintest.mat');

% [idf_confusion, idf_acc] = evaluate_IDF(dataset,'random','euclidean');
% [idf_confusion, idf_acc] = evaluate_IDF(dataset,'random','chi2');
% [idf_confusion, idf_acc] = evaluate_IDF(dataset,'harris','euclidean');
[idf_confusion, idf_acc] = evaluate_IDF(dataset,'harris','chi2');

function [confusion_matrix, accuracy] = evaluate_IDF(dataset, dict_method, dist_metric)
    if strcmp(dict_method, 'random')
        load('visionRandom.mat','trainFeatures', 'trainLabels', 'dictionary');
    else
        load('visionHarris.mat','trainFeatures', 'trainLabels', 'dictionary');
    end
    load(strcat('idf_',dict_method,'.mat'),'idf');
    n = length(dataset.test_imagenames);
    K = size(dictionary, 1);
    confusion_matrix = zeros(8,8);
    num_correct = 0;
    trainFeatures = trainFeatures.*idf;
    for i = 1 : n
        load(strcat('../data/', strrep(dataset.test_imagenames{i},'.jpg', strcat('_',dict_method,'.mat'))),'wordMap');
        hist1 = getImageFeatures(wordMap, K).*idf;
        dists = getImageDistance(hist1, trainFeatures, dist_metric);
        [~, idx] = min(dists);
        pred_label = trainLabels(idx);
        gt_label = dataset.test_labels(i);
        if gt_label == pred_label
            num_correct = num_correct + 1;
        end
        confusion_matrix(gt_label, pred_label) = confusion_matrix(gt_label, pred_label) + 1;
    end
    accuracy = num_correct/n;
    fprintf('Output of %s + %s\n', dict_method, dist_metric);
    fprintf('Accuracy: %d\n', accuracy);
    fprintf('Confusion matrix:\n');
    disp(confusion_matrix);
end