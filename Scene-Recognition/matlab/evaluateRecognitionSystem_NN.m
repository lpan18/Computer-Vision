clear all;
close all;

dataset = load('../data/traintest.mat');

[re_confusion, re_accu] = evaluate_NN(dataset,'random','euclidean');
[rc_confusion, rc_accu] = evaluate_NN(dataset,'random','chi2');
[he_confusion, he_accu] = evaluate_NN(dataset,'harris','euclidean');
[hc_confusion, hc_acc] = evaluate_NN(dataset,'harris','chi2');

function [confusion_matrix, accuracy] = evaluate_NN(dataset, dict_method, dist_metric)
    if strcmp(dict_method, 'random')
        vision = load('visionRandom.mat');
    elseif strcmp(dict_method, 'harris')
        vision = load('visionHarris.mat');
    end
    n = length(dataset.test_imagenames);
    K = size(vision.dictionary, 1);
    confusion_matrix = zeros(8,8);
    num_correct = 0;
    for i = 1 : n
        load(strcat('../data/', strrep(dataset.test_imagenames{i},'.jpg', strcat('_',dict_method,'.mat'))),'wordMap');
        hist1 = getImageFeatures(wordMap, K);
        dists = getImageDistance(hist1, vision.trainFeatures, dist_metric);
        [~, idx] = min(dists);
        pred_label = vision.trainLabels(idx);
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