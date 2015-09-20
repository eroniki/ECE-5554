clc; clear all; close all; profile on;

inputImage = imread('fish.jpg');
[h, w, c] = size(inputImage);
figure(1);
imshow(inputImage);

[outputRGB, meanColors] = quantizeRGB(inputImage,10);

figure(2);
imshow(outputRGB);

[outputHSV, meanHues] = quantizeHSV(inputImage,10);

figure(3);
imshow(outputHSV);

ssdErrorRGB = computeQuantizationError(inputImage,outputRGB);
ssdErrorHSV = computeQuantizationError(inputImage,outputHSV);