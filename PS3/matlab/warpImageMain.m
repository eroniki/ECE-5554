%% Murat Ambarkutuk PS-3
clc; close all; clear all; profile on;
% 1- Programming: Image Mosaics
%% 1-1
% Load data set
image.input = imread('../submission/crop1.jpg');
image.ref = imread('../submission/crop2.jpg');
load('../submission/cc1.mat');
load('../submission/cc2.mat');

% init points
points.input.raw = 0;
points.ref.raw = 0;

% Choose, confirm and/or correct correspondences
while(numel(points.input.raw)/4 <=4) 
    [points.input.raw, points.ref.raw] = cpselect(image.input, image.ref, cc1', cc2', 'Wait', true);
end
nPoints = size(points.input.raw,1);
% N-by-2 to 2-by-N
points.input.raw = points.input.raw';
points.ref.raw = points.ref.raw';
points.input.homogeneous = [points.input.raw; ones(1,nPoints)];
points.ref.homogeneous = [points.ref.raw; ones(1,nPoints)];

%% 1-2
% Scale the points
T1 = calculateNormalization(points.input.homogeneous);
T2 = calculateNormalization(points.ref.homogeneous);
points.input.scaled = T1*points.input.homogeneous;
points.ref.scaled = T2*points.ref.homogeneous;

% Calculate the homography matrix
H = computeH(points.input.scaled(1:2,:), points.ref.scaled(1:2,:));
points.warped.scaled = H*points.input.scaled;
poinst.warped.homogeneous = zeros(size(points.warped.scaled));
points.warped.homogeneous = inv(T2)*points.warped.scaled;
for i=1:nPoints
    points.warped.homogeneous(:,i) = points.warped.homogeneous(:,i)/points.warped.scaled(3,i);
end

%% 1-3
% Warp Image 


%% Visualizations and Figures
% Show the images
% imshow(image.input);
% imshow(image.ref);
% saveas(1, ['outputWidth', suffix, '.png'],'png');
% profile viewer