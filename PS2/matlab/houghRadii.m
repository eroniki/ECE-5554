clc; clear all; close all; profile on;

filename = {'jupiter', 'egg'};
k = 2;
im = imread([filename{k}, '.jpg']);
[h, w, ~] = size(im);

radius = 70;
useGradient = 1;
nCircles = 1;

centers = detectCircles(im, radius, useGradient);

[y,x] = ind2sub(size(centers.centers), centers.centers(1:nCircles));

figure(1); imagesc(centers.houghSpace);

figure(2); imshow(centers.edges);
figure(3); imshow(im);

centersA = [x(1:nCircles)', y(1:nCircles)'];
viscircles(centersA, repmat(radius, [nCircles,1]), 'LineWidth', 1);
profile viewer

saveas(1, ['../submission/Q2-2-houghSpace-radius-', num2str(radius), '-Grad-', num2str(useGradient), '-', '-n-', num2str(nCircles), '-', filename{k},'.png'],'png');
saveas(2, ['../submission/Q2-2-edges-radius-', num2str(radius), '-Grad-', num2str(useGradient), '-', '-n-', num2str(nCircles), '-', filename{k},'.png'],'png');
saveas(3, ['../submission/Q2-2-circles-radius-', num2str(radius), '-Grad-', num2str(useGradient), '-', '-n-', num2str(nCircles), '-', filename{k},'.png'],'png');