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
cumulativeEnergyMapV = cumulative_energy_map(energyMap, 'V');
figure(3);
imagesc(cumulativeEnergyMapV);
hold on;
minCumulativeEnergyV = min(cumulativeEnergyMapV(h,:))

optimalVerticalSeam = find_optimal_vertical_seam(cumulativeEnergyMapV);

% horizontal stuff

cumulativeEnergyMapH = cumulative_energy_map(energyMap, 'h');
minCumulativeEnergyH = min(cumulativeEnergyMapH(:,w))
optimalHorizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMapH);

% figure(4);
plot(optimalVerticalSeam, w:-1:1, 'w*');
plot(h:-1:1, optimalHorizontalSeam, 'k+');
figure(4);
imagesc(cumulativeEnergyMapH);
