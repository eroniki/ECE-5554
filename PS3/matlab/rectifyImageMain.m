%% Murat Ambarkutuk PS-3 Extra
clc; close all; clear all; profile on;
%% Lane Rectification
input = '../submission/goodwin.jpg';
image.input = imread(input);

cc1=[0;0];
cc2=[0;0];
nPoints =4;
% init points
% points.input.raw = cc1';
% points.ref.raw = cc2';
% nPoints = size(points.input.raw,1);
% % Choose, confirm and/or correct correspondences
% while(nPoints<4) 
%     [points.input.raw, points.ref.raw] = cpselect(image.input, image.ref, points.input.raw, points.ref.raw, 'Wait', true);
%     nPoints = size(points.input.raw,1);
% end
h = figure; imshow(input);
input = ginput(4);
close(h);
points.input.raw = input';

maxX = max(points.input.raw(1,:));
maxY = max(points.input.raw(2,:));

minX = min(points.input.raw(1,:));
minY = min(points.input.raw(2,:));

points.ref.raw = [1,maxX-minX,1,maxX-minX; 1,1,maxY-minY,maxY-minY ]

points.input.homogeneous = [points.input.raw; ones(1,nPoints)];
points.ref.homogeneous = [points.ref.raw; ones(1,nPoints)];

% Calculate the homography matrix
H = computeH(points.input.raw, points.ref.raw);

points.warped = H*points.input.homogeneous;
points.warped = normalizeHomogeneous(points.warped);
% Warp Image 
rectifiedIm = rectifyImage(image.input, points.input.homogeneous,H);
%% Visualizations and Figures
% Show the images
figure(1); imshow(image.input);hold on;
plot(points.input.raw(1,:), points.input.raw(2,:),'r+','MarkerSize',10);
title('Input Image (Red points represent the chosen points)');
figure(2); imshow(rectifiedIm); 
title('Output Image (Goodwin Hall)');
saveas(1, ['../submission/rectifyInput.png'],'png');
saveas(2, ['../submission/rectifyOutput.png'],'png');
% profile viewer