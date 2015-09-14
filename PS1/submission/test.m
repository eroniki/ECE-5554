% Compute and display for just the first seams
close all, clear all, clc;
profile on;

p = profile('status');
suffix = 'Prague';
% Load the image and show the original work
inputFile = ['inputSeamCarving', suffix, '.jpg'];
outputFile= ['outputReduceWidth', suffix, '.png'];

frame = imread(inputFile);

[h, w, c] = size(frame);
% Compute and acquire the energy map
energyMap = energy_image(frame);  


% Calculate cumulative energy maps 
cumulativeEnergyMapV = cumulative_energy_map(energyMap, 'V');
cumulativeEnergyMapH = cumulative_energy_map(energyMap, 'H');
%

% Find the optimal seams

optimalVerticalSeam = find_optimal_vertical_seam(cumulativeEnergyMapV);
optimalHorizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMapH);


figure(1) 
subplot(2,2,1), imshow(frame), title('Input Image');
subplot(2,2,2), imagesc(energyMap), title('Energy Map of Input Image (Prague)');
subplot(2,2,3), imagesc(cumulativeEnergyMapH), title('Cumulative Energy Map in Hor. Dir.');
subplot(2,2,4), imagesc(cumulativeEnergyMapV), title('Cumulative Energy Map in Ver. Dir.');
saveas(1, 'cumulatives.png','png');
figure(2)
imshow(frame);
hold on
plot(optimalVerticalSeam, 1:h, 'r.');
plot(1:w, optimalHorizontalSeam, 'b.');
saveas(2, 'seams.png','png');
