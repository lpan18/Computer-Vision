% Code written by Matthew Marinets from the class of 2019 Fall at SFU.
%
% a script for testing each kind of forward layer
close all;

global resultsdir
resultsdir = '../test';
[~,~,~] = mkdir(resultsdir);

test_conv_1();
test_conv_2();
test_pooling_1();
test_inner_1();

function test_pooling_1()
    input.data = zeros(36*3,2);
    input.data(13, 1) = 0.5;
    input.data(14, 1) = 0.25;
    input.data(15, 1) = 0.5;
    input.data(20 + 50, 1) = 0.75;
    % image 2
    input.data(15, 2) = 0.25;
    input.data(16, 2) = 0.75;
    input.data(6 + 36, 2) = 0.75;
    input.data(12 + 72, 2) = 0.75;
    input.width = 6;
    input.height = 6;
    input.channel = 3;
    input.batch_size = 2;
    
    layer.type = 'POOLING';
    layer.k = 2;
    layer.stride = 2;
    layer.pad = 0;
    
    output = pooling_layer_forward(input, layer);
    display_results(input, output, 'Pooling Test');
end

function test_inner_1()
    input.data = zeros(25,2);
    input.data(13, 1) = 1; % middle pixel on
    input.data(14, 2) = 1; % pixel below middle pixel on
    input.width = 5;
    input.height = 5;
    input.channel = 1;
    input.batch_size = 2;
    
    layer.type = 'IP';
    layer.num = 25;
    
    params.w = zeros(25);
    params.w(13, 13) = 1.0;
    params.w(13, 14) = 0.5;
    params.w(14, 15) = 0.5;
    params.b = zeros(1,25);
    params.b(1,2) = 0.25;
    
    output = inner_product_forward(input, layer, params);
    display_results(input, output, 'Inner Product Test');
end

function test_conv_1()
    input.data = zeros(25, 2);
    input.data(13, 1) = 1;
    input.data(14, 2) = 1;
    input.width = 5;
    input.height = 5;
    input.channel = 1;
    input.batch_size = 2;

    conv_layer.type = 'CONV';
    conv_layer.num = 3;
    conv_layer.k = 5;
    conv_layer.stride = 1;
    conv_layer.pad = 2;
    
    params.w = zeros(25,3);
    params.w(14, 1) = 0.5; % move image down by one pixel on red channel
    params.w(12+5, 3) = 0.5; % move image opposite dir blue channel
    params.b = [0.25, 0.0, 0.25];

    output = conv_layer_forward(input, conv_layer, params);
    display_results(input, output, 'Convolution Test 1');

end

function test_conv_2()
    input.data = zeros(75, 2);
    input.data(13, 1) = 1;
    input.data(13+50, 1) = 1;
    input.data(14, 2) = 1;
    input.data(15+25, 2) = 1;
    input.width = 5;
    input.height = 5;
    input.channel = 3;
    input.batch_size = 2;

    conv_layer.type = 'CONV';
    conv_layer.num = 3;
    conv_layer.k = 5;
    conv_layer.stride = 1;
    conv_layer.pad = 2;
    
    params.w = zeros(75,3);
    % what it does to red
    params.w(14, 1) = 0.5; % move image down by one pixel on red channel
    params.w(12+5, 3) = 0.5; % move image opposite dir blue channel
    % what it does to green
    params.w(13 + 25, 3) = 0.5; % stay in place on blue
    params.w(13 + 5 + 25, 2) = 1; % move right on green
    % what it does to blue
    params.w(13 + 50, 1) = 1.0; % stay in place
    params.w(13 + 50, 2) = 1.0; % stay in place
    params.w(13 + 50, 3) = 1.0; % stay in place
    % bias
    params.b = [0.25, 0.0, 0.25];

    output = conv_layer_forward(input, conv_layer, params);
    display_results(input, output, 'Convolution Test 2');

end

function display_results(input, output, testname)
    global resultsdir;
    
    fig = figure;
    img1 = reshape(output.data(:,1), output.height, output.width, output.channel);
    subplot(2,2,2);
    imshow(img1);
    title('Output 1');
    img2 = reshape(output.data(:,2), output.height, output.width, output.channel);
    subplot(2,2,4);
    imshow(img2);
    title('Output 2');
    
    % inputs
    imgin1 = reshape(input.data(:,1), input.height, input.width, input.channel);
    subplot(2,2,1);
    imshow(imgin1);
    title('Input 1');
    imgin2 = reshape(input.data(:,2), input.height, input.width, input.channel);
    subplot(2,2,3);
    imshow(imgin2);
    title('Input 2');
    
    sgtitle(testname);
    
    filename = [resultsdir sprintf('/%s.png', testname)];
    frame = getframe(fig);
    imwrite(frame2im(frame), filename);
end
