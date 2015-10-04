 clc; clear all; close all; profile on;

im = imread('jupiter.jpg');
[h, w, ~] = size(im);
imgray = rgb2gray(im);
maxDim = max(h,w);
frame = zeros(h,w, 'uint8');

radius = 75;
useGradient = 1;

centers = detectCircles(im, 50:100, useGradient);
% centers = detectCircles(im, 75, useGradient);

[i,j] = ind2sub(size(centers.centers), centers.centers);
figure(1); imagesc(centers.houghSpace);

figure(2); imshow(im);
figure(3); imshow(centers.edges);

for q=1:10
    circle.x = j(q);
    circle.y = i(q)
    size.h = h;
    size.w = w;
    geometry = circleCoordinates(circle, radius, size);
    figure(4); hold on; imshow(geometry.frame);
end
profile viewer