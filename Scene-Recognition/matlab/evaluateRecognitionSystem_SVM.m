clear all;
close all;

dataset = load('../data/traintest.mat');

% [re_confusion, re_accu] = evaluate_SVM(dataset,'random','euclidean');
% [rc_confusion, rc_accu] = evaluate_SVM(dataset,'random','chi2');
[he_confusion, he_accu] = evaluate_SVM(dataset,'harris','euclidean');
[hc_confusion, hc_acc] = evaluate_SVM(dataset,'harris','chi2');

function [confusion_matrix, accuracy] = evaluate_SVM(dataset, dict_method, dist_metric)

    if strcmp(dict_method, 'random')
        vision = load('visionRandom.mat');
    else
        vision = load('visionHarris.mat');
    end

    n = length(dataset.test_imagenames);
    K = size(vision.dictionary, 1);
    confusion_matrix = zeros(8,8); %zeros(n, n);
    num_correct = 0;

    t = templateSVM('KernelFunction','gaussian');
%     t = templateSVM('KernelFunction','polynomial');
    model = fitcecoc(vision.trainFeatures, vision.trainLabels, 'Learners', t);
    save('visionSVM.mat','model');

    for i = 1 : n
        load(strcat('../data/', strrep(dataset.train_imagenames{i},'.jpg', strcat('_',dict_method,'.mat'))),'wordMap');
        hist = getImageFeatures(wordMap, K);
        pred_label = predict(model, hist);
        gt_label = dataset.test_labels(i);
        if gt_label == pred_label
            num_correct = num_correct + 1;
        end
        confusion_matrix(gt_label, pred_label) = confusion_matrix(gt_label, pred_label) + 1;
    end
    accuracy = num_correct/n;
end