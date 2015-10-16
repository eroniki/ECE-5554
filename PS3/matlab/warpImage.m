%% Murat Ambarkutuk PS-3
clc; close all; clear all; profile on;
% 1- Programming: Image Mosaics
%% 1-1
% Load data set
image.Left = imread('../submission/crop1.jpg');
image.Right = imread('../submission/crop2.jpg');
load('../submission/cc1.mat');
load('../submission/cc2.mat');
% Show the images
% imshow(image.Left);
% imshow(image.Right);
% init points
points.Left = 0;
points.Right = 0;
% Confirm and/or correct the points
while(numel(points.Left)/4 <=4) 
    [points.Left, points.Right] = cpselect(image.Left, image.Right, cc1', cc2', 'Wait', true);
end
nPoints = numel(points.Left)/2;
% N-by-2 to 2-by-N
points.Left = points.Left';
points.Right = points.Right';
points.LeftHomogenious = [points.Left; ones(1,nPoints)];
points.RightHomogenious = [points.Right; ones(1,nPoints)];
%% 1-2
% Scale the points
T1 = calculateNormalization(points.LeftHomogenious);
T2 = calculateNormalization(points.RightHomogenious);
points.LeftScaled = T1*points.LeftHomogenious;
points.RightScaled = T2*points.RightHomogenious;

% Calculate the homography matrix
H = computeH(points.LeftScaled(1:2,:), points.RightScaled(1:2,:));
pointsWarped = H*points.LeftScaled;
poinstWarpedHomo = zeros(size(pointsWarped));
pointsWarpedHomo = inv(T2)*pointsWarped;
for i=1:nPoints
    pointsWarpedHomo(:,i) = pointsWarpedHomo(:,i)/pointsWarped(3,i);
end
pointsWarpedHomo
%% Visualizations and Figures
% saveas(1, ['outputWidth', suffix, '.png'],'png');
% profile viewer