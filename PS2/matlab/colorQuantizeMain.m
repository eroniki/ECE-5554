%% 2- Programming
clc; clear all; close all; profile on;
%% 2-1-
figure(1);
inputImage.RGB = imread('fish.jpg');
subplot(3,1,1); imshow(inputImage.RGB); title('Input Image');
[h, w, c] = size(inputImage.RGB);

nCluster = 10;

% 2-1-a
[outputImage.RGB, meanColors] = quantizeRGB(inputImage.RGB, nCluster);
subplot(3,1,2); imshow(outputImage.RGB); title('RGB Quantized Image');

% 2-1-a::visuals
[COUNTS1,X1] = imhist(outputImage.RGB(:,:,1));
[COUNTS2,X2] = imhist(outputImage.RGB(:,:,2));
[COUNTS3,X3] = imhist(outputImage.RGB(:,:,3));
figure(2); hold on; grid MINOR; title('Number of Pixels by the Channels');
stem(X1,COUNTS1, 'r', 'LineWidth', 3);
stem(X2,COUNTS2, 'g', 'LineWidth', 3);
stem(X3,COUNTS3, 'b', 'LineWidth', 3);
legend('Location', 'NorthEast', 'Red Channel', 'Blue Channel', 'Green Channel');

% 2-1-b
inputImage.HSV = rgb2hsv(inputImage.RGB);
inputImage.HSVuint = uint8(inputImage.HSV*255);
[outputImage.HSV, meanHues] = quantizeHSV(inputImage.HSVuint, nCluster);
figure(1);
subplot(3,1,3); imshow(hsv2rgb(double(outputImage.HSV)/255.0)); title('HSV Quantized Image');

% 2-1-b::visuals
[COUNTS1,X1] = imhist(outputImage.HSV(:,:,1));
[COUNTS2,X2] = imhist(outputImage.HSV(:,:,2));
[COUNTS3,X3] = imhist(outputImage.HSV(:,:,3));
figure(3); hold on; grid MINOR; title('Number of Pixels by the Channels');
stem(X1,COUNTS1, 'r', 'LineWidth', 3);
stem(X2,COUNTS2, 'g', 'LineWidth', 3);
stem(X3,COUNTS3, 'b', 'LineWidth', 3);
legend('Location', 'NorthEast', 'Hue Channel', 'Saturation Channel', 'Value Channel');

% 2-1-c
error = computeQuantizationError(inputImage.RGB,outputImage.RGB)

% 2-1-d
[histEqual, histClustered] = getHueHists(inputImage.RGB, nCluster);