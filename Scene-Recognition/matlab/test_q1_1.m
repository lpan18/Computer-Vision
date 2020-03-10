clear all;
close all;
image = imread('../data/desert/sun_adpbjcrpyetqykvt.jpg');
I = im2double(image);
[filterBank] = createFilterBank();
[filterResponses] = extractFilterResponses(I, filterBank);
for k = [3,8,13,18]
    figure(k)
    resp = filterResponses(:,:,k*3-2:k*3);
    for i = 1:3
        subplot(1,3,i),imshow(resp(:,:,i),[]);
    end
end