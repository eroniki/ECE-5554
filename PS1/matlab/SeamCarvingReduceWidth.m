% Clear command window and workspace, close all figures
close all, clear all, clc;

% Load the image and show the original work
frame = imread('poe-raven.jpg');
[h, w, ~] = size(frame);
figure(1);
imshow(frame)

% Compute and acquire the energy map
% TODO - imgradient requires me to pass grayscale image!
energyMap = energy_image(frame);
figure(2);
imshow(energyMap);

% Calculate cumulative energy map
cumulativeEnergyMap = cumulative_energy_map(energyMap, 'V');
figure(3);
imagesc(cumulativeEnergyMap);

minCumulativeEnergy = min(cumulativeEnergyMap(h,:));




