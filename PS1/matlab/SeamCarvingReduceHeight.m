% Clear command window and workspace, close all figures
close all, clear all, clc;
profile on;

p = profile('status');
suffix = 'Prague';
% Load the image and show the original work
inputFile = ['inputSeamCarving', suffix, '.jpg'];
outputFile= ['outputReduceHeight', suffix, '.png'];

frame = imread(inputFile);

[h, w, c] = size(frame);
% Compute and acquire the energy map
% TODO - imgradient requires me to pass grayscale image!
energyMap = energy_image(frame);

newImage = frame;
newImageGreedy = frame;
newEnergyMap = energyMap;
newEnergyMapGreedy = energyMap;
for k=1:100
    [newImage, newEnergyMap] = reduceHeight(newImage,newEnergyMap);
    [newImageGreedy, newEnergyMapGreedy] = reduceHeightGreedy(newImageGreedy,newEnergyMapGreedy);
end

imwrite(newImage, outputFile);
comparisonOriginal = imfuse(frame,newImage,'falsecolor');
imwrite(comparisonOriginal, ['outputReduceHeightComparison', suffix, '.png']);
comparisonOriginal = imfuse(newImage,newImageGreedy,'falsecolor');
imwrite(comparisonOriginal, ['outputReduceHeightComparison2', suffix, '.png']);
figure(1);
subplot(2,2,1), imshow(frame), title('Input Image');
subplot(2,2,2), imshowpair(newImage,newImageGreedy), title('Comparison');
subplot(2,2,3), imshow(newImage), title('Output Image (Dynamic Programming)');
subplot(2,2,4), imshow(newImageGreedy), title('Output Image (The Greedy Method)');
saveas(1, ['outputHeight', suffix, '.png'],'png');