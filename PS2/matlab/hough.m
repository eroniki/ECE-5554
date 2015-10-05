 clc; clear all; close all; profile on;

im = imread('jupiter.jpg');
[h, w, ~] = size(im);
maxDim = max(h,w);
frame = zeros(h,w, 'uint8');

radius = 30;
useGradient = 1;
radii = 50:100;
nCircles = 5;

centers = detectCircles(im, radius, useGradient);

[y,x] = ind2sub(size(centers.centers), centers.centers(1:nCircles));

figure(1); imagesc(centers.houghSpace);

figure(2); imshow(centers.edges);
figure(3); imshow(im);

centersA = [x(1:nCircles)', y(1:nCircles)']
bidi = repmat(radius, [nCircles,1])
viscircles(centersA, bidi);

profile viewer
