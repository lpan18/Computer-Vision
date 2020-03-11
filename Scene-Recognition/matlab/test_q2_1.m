clear all;
close all;
% batchToVisualWords(4);

% I = im2double(imread('../data/bedroom/sun_bgfjnyewrxozjnet.jpg'));
% % I = im2double(imread('../data/bedroom/sun_awqizimzrhkliobj.jpg'));
% % I = im2double(imread('../data/bedroom/sun_aweaiwcjpyjurkxw.jpg'));
% 
I = im2double(imread('../data/airport/sun_aesovualhburmfhn.jpg'));
% % I = im2double(imread('../data/airport/sun_afbaefjxeoqkdwts.jpg'));
% % I = im2double(imread('../data/airport/sun_aferisdmjeibigjh.jpg'));
% 
load('dictionaryRandom.mat','filterBank','dictionaryRandom');
load('dictionaryHarris.mat','filterBank','dictionaryHarris');

wordMapRandom = getVisualWords(I, filterBank, dictionaryRandom');
wordMapHarris = getVisualWords(I, filterBank, dictionaryHarris');

subplot(1,3,1);
imshow(I);
title('Original');

subplot(1,3,2);
imshow(label2rgb(wordMapRandom));
title('Random');

subplot(1,3,3);
imshow(label2rgb(wordMapHarris));
title('Harris');

% h = getImageFeatures(wordMap, size(dictionaryHarris,1));
