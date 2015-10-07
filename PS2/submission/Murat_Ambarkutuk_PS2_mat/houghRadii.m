clc; clear all; close all; profile on;

filename = {'jupiter', 'egg'};
k = 1;
im = imread([filename{k}, '.jpg']);
[h, w, ~] = size(im);

radii = [16,30,50];
useGradient = 0;
nCircles = 3;

[centers] = detectCirclesRadii(im, radii, useGradient);

[y,x] = ind2sub([h,w], centers.centers(1,1,:));
y = y(:);
x = x(:);
for ind=1:numel(radii);
    figure(ind); imagesc(centers.houghSpace(:,:,ind)); title(['Hough Space (r=', num2str(radii(ind)), ')'])
    saveas(ind, ['../submission/Q2-2/Q2-2-Extra-houghSpace-radius-', num2str(radii(ind)), '-Grad-', num2str(useGradient), '-', '-n-', num2str(nCircles), '-', filename{k},'.png'],'png');
end
figure(4); imshow(centers.edges);
figure(5); imshow(im);

centersA = [x(1:nCircles), y(1:nCircles)];
viscircles(centersA, radii', 'LineWidth', 1);
profile viewer

saveas(4, ['../submission/Q2-2/Q2-2-Extra-edges-radius-multiple-Grad-', num2str(useGradient), '-', '-n-', num2str(nCircles), '-', filename{k},'.png'],'png');
saveas(5, ['../submission/Q2-2/Q2-2-Extra-circles-radius-multiple-Grad-', num2str(useGradient), '-', '-n-', num2str(nCircles), '-', filename{k},'.png'],'png');