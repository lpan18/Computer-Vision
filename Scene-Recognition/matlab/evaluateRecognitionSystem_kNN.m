clear all;
close all;

dataset = load('../data/traintest.mat');
num = 40;
mats = zeros(8, 8, num);
accus = zeros(1, num);
for kn = 1:num
    [confusion_matrix, accuracy] = evaluate_kNN(dataset, kn, 'harris','euclidean');
    mats(:,:,kn) = confusion_matrix;
    accus(1,kn) = accuracy;
end
figure;
plot(1:num, accus);
[max_accu, idx] = max(accus);
fprintf('Best Accuracy: %d\n', max_accu);
fprintf('Confusion matrix:\n');
disp(mats(:,:,idx))

function [confusion_matrix, accuracy] = evaluate_kNN(dataset, kn, dict_method, dist_metric)
    if strcmp(dict_method, 'random')
        vision = load('visionRandom.mat');
    else
        vision = load('visionHarris_FG.mat');
    end
    n = length(dataset.test_imagenames);
    K = size(vision.dictionary, 1);
    confusion_matrix = zeros(8,8); %zeros(n, n);
    num_correct = 0;
    for i = 1 : n
        load(strcat('../data_gar/', strrep(dataset.test_imagenames{i},'.jpg', strcat('H.mat'))), 'wordMap');
        hist1 = getImageFeatures(wordMap, K);
        dists = getImageDistance(hist1, vision.trainFeatures, dist_metric);
        [~, idx] = sort(dists, 'ascend');
        indices = idx(1:kn);
        pred_labels = vision.trainLabels(indices);
        pred_label = mode(pred_labels);
        gt_label = dataset.test_labels(i);
        if gt_label - pred_label == 0
            num_correct = num_correct + 1;
        end
        confusion_matrix(gt_label, pred_label) = confusion_matrix(gt_label, pred_label) + 1;
    end
    accuracy = num_correct/n;
%     fprintf('Output of %s + %s\n', dict_method, dist_metric);
%     fprintf('Accuracy: %d\n', accuracy);
%     fprintf('Confusion matrix:\n');
%     disp(confusion_matrix);
end