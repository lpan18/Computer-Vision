dataset = load('../data/traintest.mat');
T = length(dataset.train_imagenames);
vision = load('visionRandom.mat');
K = size(vision.dictionary, 1);
idf = zeros(1,K);
for i=1:K
    count = sum(vision.trainFeatures(i,:) > 0);
    idf(1,i)=log(T/count); 
end
save('idf_random.mat','idf');

vision = load('visionHarris.mat');
idf = zeros(1,K);
for i=1:K
    count = sum(vision.trainFeatures(i,:) > 0);
    idf(1,i)=log(T/count); 
end
save('idf_harris.mat','idf');
