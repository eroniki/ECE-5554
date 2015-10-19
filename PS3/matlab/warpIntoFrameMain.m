%% Murat Ambarkutuk PS-3
clc; close all; clear all; profile on;
% 1- Programming: Image Mosaics
%% Load data set
input ='../submission/cvpr.png';
ref = '../submission/billboard.jpg';

image.input = imread(input);
image.ref = imread(ref);

cc1=[0;0];
cc2=[0;0];

%% init points
points.input.raw = cc1';
points.ref.raw = cc2';
nPoints = size(points.input.raw,1);
%% Choose, confirm and/or correct correspondences
while(nPoints<4) 
    [points.input.raw, points.ref.raw] = cpselect(image.input, image.ref, points.input.raw, points.ref.raw, 'Wait', true);
    nPoints = size(points.input.raw,1);
end

%% N-by-2 to 2-by-N
points.input.raw = points.input.raw';
points.ref.raw = points.ref.raw';
points.input.homogeneous = [points.input.raw; ones(1,nPoints)];
points.ref.homogeneous = [points.ref.raw; ones(1,nPoints)];

%% Calculate the homography matrix
H = computeH(points.input.raw, points.ref.raw);
%% H = inv(T2)*H;
points.warped = H*points.input.homogeneous;
points.warped = normalizeHomogeneous(points.warped);
%% Warp Image 
[warpedIm, mergeIm] = warpIntoFrame(image.input, image.ref, H);
%% Visualizations and Figures
% Show the images
figure(1); imshow(image.input);
figure(2); imshow(image.ref);
figure(3); imshow(warpedIm);
figure(4); imshow(mergeIm);
% saveas(1, ['outputWidth', suffix, '.png'],'png');
% profile viewer