% Clear command window and workspace, close all figures
close all, clear all, clc;

% Load the image and show the original work
frame = imread('inputSeamCarvingPrague.jpg');
% frame = imread('fsm.jpg');
[h, w, c] = size(frame);

% Compute and acquire the energy map
% TODO - imgradient requires me to pass grayscale image!
energyMap = energy_image(frame);
figure(1);
imshow(frame);
newImage = frame;
newEnergyMap = energyMap;

for k=1:100
	[newImage, newEnergyMap] = reduceWidth(newImage,newEnergyMap);
end

imwrite(newImage, 'outputReduceWidthPrague.png');
figure(99), imshow(newImage);