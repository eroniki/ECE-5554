% Clear command window and workspace, close all figures
close all, clear all, clc;

% Load the image and show the original work
frame = imread('inputSeamCarvingPrague.jpg');
% frame = imread('fsm.jpg');
[h, w, c] = size(frame);

% Compute and acquire the energy map
% TODO - imgradient requires me to pass grayscale image!
energyMap = energy_image(frame);

newImage = frame;
newImageGreedy = frame;
newEnergyMap = energyMap;
newEnergyMapGreedy = energyMap;
for k=1:100
	[newImage, newEnergyMap] = reduceWidth(newImage,newEnergyMap);
    [newImageGreedy, newEnergyMapGreedy] = reduceWidthGreedy(newImageGreedy,newEnergyMapGreedy);
end

imwrite(newImage, 'outputReduceWidthPrague.png');
figure(1);
subplot(2,2,1), imshow(frame), title('Input Image');
subplot(2,2,2), imshowpair(newImage,newImageGreedy), title('Comparison');
subplot(2,2,3), imshow(newImage), title('Output Image (Dynamic Programming)');
subplot(2,2,4), imshow(newImageGreedy), title('Output Image (Dynamic Programming)');